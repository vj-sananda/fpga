/* Non blocking interface for reads and writes in all environments. */

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>

#ifdef VCS
#	include "vcsuser.h"
#else
#	include "veriuser.h"
#endif
 
#include "acc_user.h"
#include "nvstatic.h"
#include "nonBlockInterfacePLI.h"
 
#if ! defined (ACC_VER)
#define ACC_VER		"1.8"
#endif


/*----------------------------------------------------------*/
/*	gblTransactionNodeStreamIdPtr -----> node1 ------------> node2....
	                                     |                   |
                                         v                   v
                                         QData1              QData1
                                         |
                                         v
                                         QData2
                                         ....

    gblWrtDataNodeStreamIdPtr ----> node1, streamId1 -----> node2, streamId2....
	                                |                       |
                                    v                       v
                                    QData1                  QData1
                                    |
                                    v
                                    QData2
                                    ....

    gblRdDataNodeStreamIdPtr -----> node1, streamId1 -----> node2, streamId2....
	                                |                       |
                                    v                       v
                                    QData1                  QData1
                                    |
                                    v
                                    QData2
                                    ....

    gblRdDoneNodeStreamIdPtr -----> node1, streamId1 -----> node2, streamId2....
	                                |                       |
                                    v                       v
                                    QData1                  QData1
                                    |
                                    v
                                    QData2
                                    ....

	gblSyncCntNodeStreamIdPtr ------> type1 -------> type2....
                                      |              |
                                      v              v
                                      syncCnt1       syncCnt2

*/

/*----------------------------------------------------------*/
/* Globals. */
/* Qs. */
nodeStreamIdPtrType gblTransactionCtxNodeStreamIdPtr =
	(nodeStreamIdPtrType) null;
nodeStreamIdPtrType gblTransactionNodeStreamIdPtr = (nodeStreamIdPtrType) null;
nodeStreamIdPtrType gblWrtDataNodeStreamIdPtr = (nodeStreamIdPtrType) null;
nodeStreamIdPtrType gblRdDataNodeStreamIdPtr = (nodeStreamIdPtrType) null;
nodeStreamIdPtrType gblRdDoneNodeStreamIdPtr = (nodeStreamIdPtrType) null;
nodeStreamIdPtrType gblRdReqNodeStreamIdPtr = (nodeStreamIdPtrType) null;
nodeStreamIdPtrType gblWaitNodeStreamIdPtr = (nodeStreamIdPtrType) null;

/* Data arrays. */
nodeStreamIdPtrType gblSyncCntNodeStreamIdPtr = (nodeStreamIdPtrType) null;
nodeStreamIdPtrType gblSyncFlagNodeStreamIdPtr = (nodeStreamIdPtrType) null;

/*----------------------------------------------------------*/
/* Return maximum parameter size in bits.  Used in veriuser.c. */

int
SizeNonBlockInterfacePLI ()
 
{
	return (32);
}

/*---------------------------------------------------------------*/
/* Initialize one nodeStreamIdNode and return a pointer to it. */

nodeStreamIdPtrType
IniNodeStreamIdPtr ()

{
	nodeStreamIdPtrType nodeStreamIdPtr;

	if ((nodeStreamIdPtr = (nodeStreamIdPtrType) calloc (1,
		sizeof (nodeStreamIdStructType))) == (nodeStreamIdPtrType) null)
	{
		PRINTF ("Error:  Can't calloc nodeStreamIdPtr!\n");
		exit (1);
	}

	return (nodeStreamIdPtr);
}

/*---------------------------------------------------------------*/
/* Allocate one dataPtr, a generic pointer to a data structure,
	with a structure size of sizeOfStruct.  The function passes back
	a char * pointer.  The calling function must set up the correct
	type.  e.g.  QDataPtr = (QDataPtrType) IniGenericPtr (
	sizeof (QDataStructType)); */

char *
IniGenericPtr (sizeOfStruct)
int sizeOfStruct;

{
	char *QDataPtr;

	if ((QDataPtr = (char *) calloc (1, sizeOfStruct)) == (char *) null)
	{
		PRINTF ("Error:  Can't calloc QDataPtr!\n");
		exit (1);
	}

	return (QDataPtr);
}

/*---------------------------------------------------------------*/
/* Add a value to a queue.  QDataPtr is a generic pointer to a
	data structure. */

void
PushQ1 (QPtr, QDataPtr)
QPtrType *QPtr;
char *QDataPtr;

{
	QPtrType presQPtr;

	if ((presQPtr = (QPtrType) calloc (1, sizeof (QStructType))) ==
		(QPtrType) null)
	{
		PRINTF ("Error:  Can't calloc QPtr!\n");
		exit (1);	
	}
	else
	{
		if (*QPtr == (QPtrType) null)
		{
			*QPtr = presQPtr;
			presQPtr -> next = presQPtr;
			presQPtr -> prev = presQPtr;
		}
		else
		{
			presQPtr -> next = *QPtr;
			presQPtr -> prev = (*QPtr) -> prev;
			(*QPtr) -> prev -> next = presQPtr;
			(*QPtr) -> prev = presQPtr;
		}
	}

	presQPtr -> QDataPtr = QDataPtr;
}

/*---------------------------------------------------------------*/
/* Get a value from the queue. */

char *
StatusQ1 (QPtr)
QPtrType *QPtr;

{
  char *QDataPtr = (char *) null;

  if (*QPtr != (QPtrType) null)
    QDataPtr = (*QPtr) -> QDataPtr;

  return (QDataPtr);
}

/*---------------------------------------------------------------*/
/* Get a value from the queue. */

char *
PopQ1 (QPtr)
QPtrType *QPtr;

{
	char *QDataPtr = (char *) null;
	QPtrType newQPtr;

	if (*QPtr != (QPtrType) null)
	{
		QDataPtr = (*QPtr) -> QDataPtr;

		/* Is this the last element? */
		if ((newQPtr = (*QPtr) -> next) == *QPtr)
		{
			/* Last. */
			newQPtr = (QPtrType) null;
		}
		else
		{
			/* Not last. */
			/* Take out links to *QPtr. */
			(*QPtr) -> next -> prev = (*QPtr) -> prev;
			(*QPtr) -> prev -> next = (*QPtr) -> next;
		}

		/* Remove the top. */
		free (*QPtr);
		*QPtr = newQPtr;
	}

	return (QDataPtr);
}

/*----------------------------------------------------------*/
/* Search for a nodeStreamIdPtr with a matching node, streamId. */

nodeStreamIdPtrType
FindNodeStreamIdPtr (nodeStreamIdPtr, node, streamId)
nodeStreamIdPtrType nodeStreamIdPtr;
unsigned int node, streamId;

{
	int found = false;

	while ((nodeStreamIdPtr != (nodeStreamIdPtrType) null) && ! found)
	{
		if ((nodeStreamIdPtr -> node != node) ||
			(nodeStreamIdPtr -> streamId != streamId))
			nodeStreamIdPtr = nodeStreamIdPtr -> next;
		else
			found = true;
	}

	return (nodeStreamIdPtr);
}

/*----------------------------------------------------------*/
/* Search for a nodeStreamIdPtr with a matching node, streamId.  If
	a nodeStreamIdPtr does not exist, create one. */

nodeStreamIdPtrType
FindOrCreateNodeStreamIdPtr (nodeStreamIdPtr, node, streamId)
nodeStreamIdPtrType *nodeStreamIdPtr;
unsigned int node, streamId;

{
	nodeStreamIdPtrType presNodeStreamIdPtr;

	/* Find it first. */
	if ((presNodeStreamIdPtr = FindNodeStreamIdPtr (*nodeStreamIdPtr, node,
		streamId)) == (nodeStreamIdPtrType) null)
	{
		/* Can't find it so create it. */
		presNodeStreamIdPtr = IniNodeStreamIdPtr ();
		presNodeStreamIdPtr -> node = node;
		presNodeStreamIdPtr -> streamId = streamId;

		/* Link in one nodeStreamId structure. */
		presNodeStreamIdPtr -> next = *nodeStreamIdPtr;
		*nodeStreamIdPtr = presNodeStreamIdPtr;
	}

	return (presNodeStreamIdPtr);
}

/*----------------------------------------------------------*/
/* Return nodeStreamIdPtr to an indexed global transaction
	related Q for a particular node or node/streamId combination.  */

nodeStreamIdPtrType
FindGblIdxNodeStreamIdPtr (node, streamId, i)
unsigned int node, streamId;
int i;

{
	nodeStreamIdPtrType nodeStreamIdPtr = (nodeStreamIdPtrType) null;

	switch (i)
	{
		case 0: 
			/* Change context in transaction Q. */
			nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
				&gblTransactionNodeStreamIdPtr, node, 0);
			break;
		case 1:
			/* Change context in wrtData Q. */
			nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
				&gblWrtDataNodeStreamIdPtr, node, streamId);
			break;
		case 2:
			/* Change context in rdData Q. */
			nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
				&gblRdDataNodeStreamIdPtr, node, streamId);
			break;
		case 3:
			/* Change context in rdDone Q. */
			nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
				&gblRdDoneNodeStreamIdPtr, node, streamId);
			break;
		case 4:
			/* Change context in rdReq Q. */
			nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
				&gblRdReqNodeStreamIdPtr, node, streamId);
			break;
	}

	return (nodeStreamIdPtr);
}

/*----------------------------------------------------------*/
/* Synchronize context switches on a pop.  The current node
	must be complete with its current transaction inorder
	to pop a value.  This will notify Push* routines not
	to use the original QPtr anymore. */

void
SyncCtx (node, streamId)
unsigned int node, streamId;

{
	int i;
	nodeStreamIdPtrType nodeStreamIdPtr;

	for (i = 0; i < 5; i++)
	{
		nodeStreamIdPtr = FindGblIdxNodeStreamIdPtr (node, streamId, i);

		if (nodeStreamIdPtr -> QCtxPtr)
			if (nodeStreamIdPtr -> QCtxPtr -> oldQPtrValid)
				nodeStreamIdPtr -> QCtxPtr -> oldQPtrValid = false;
	}
}

/*----------------------------------------------------------*/
/* Pop QDataPtr from the correct Q.  This function is called
	instead of PopQ1 for transaction Qs.*/

char *
PopQCtx (nodeStreamIdPtr)
nodeStreamIdPtrType nodeStreamIdPtr;

{
	char *QDataPtr;

	/* Popping off old Q?  Get pointer to old Q.  Context may
		have changed and was not synchronized. */
	if (nodeStreamIdPtr -> QCtxPtr)
	{
		if (nodeStreamIdPtr -> QCtxPtr -> oldQPtrValid)
			QDataPtr =  PopQ1 (&(nodeStreamIdPtr -> QCtxPtr ->
				oldQPtrNodeStreamIdPtr -> QPtr));
		else
			QDataPtr =  PopQ1 (&(nodeStreamIdPtr -> QPtr));
	}
	else
	{
		QDataPtr =  PopQ1 (&(nodeStreamIdPtr -> QPtr));
	}

	return (QDataPtr);
}

/*----------------------------------------------------------*/
/* Push QDataPtr onto the correct Q depending on the current streamId
	context.  This function is called instead of PushQ1 for
	transaction Qs. */

void
PushQCtx (streamId, nodeStreamIdPtr, QDataPtr)
unsigned int streamId;
nodeStreamIdPtrType nodeStreamIdPtr;
char *QDataPtr;

{
	nodeStreamIdPtrType stackNodeStreamIdPtr = (nodeStreamIdPtrType) null;
	nodeStreamIdPtrType ctxCntNodeStreamIdPtr;
	unsigned int ctxCnt;

	/* Does a seperate Q ctx exist? */
	if (nodeStreamIdPtr -> QCtxPtr)
	{
		/* Find the context count pointer for a particular streamId. */
		if ((ctxCntNodeStreamIdPtr = (FindNodeStreamIdPtr (
			nodeStreamIdPtr -> QCtxPtr -> ctxCntNodeStreamIdPtr, 0,
			streamId))))
		{
			/* Get streamId context count. */
			ctxCnt = (unsigned int)((char*)(ctxCntNodeStreamIdPtr->otherDataPtr) - (char*)0);
		}
		else
		{
			/* This stream does not have a context count. */
			ctxCnt = 0;
		}

		/* If streamId ctx count is not current, push data on proper
			ctx Q. */
		if (ctxCnt < (nodeStreamIdPtr -> QCtxPtr -> ctxCnt))
		{
			/* Find the stack pointer for the streamId context count. */
			stackNodeStreamIdPtr = FindNodeStreamIdPtr (
				nodeStreamIdPtr -> QCtxPtr -> stackNodeStreamIdPtr,
				0, ctxCnt);
		}
	}

	if (stackNodeStreamIdPtr)
		/* Another Q ctx. */
		PushQ1 (&(stackNodeStreamIdPtr -> QPtr), (char *) QDataPtr);
	else
		/* Current Q. */
		PushQ1 (&(nodeStreamIdPtr -> QPtr), (char *) QDataPtr);
}

/*----------------------------------------------------------*/
/* RetrieveTransactionCtx (node, streamId); */

void
RetrieveTransactionCtx (node, streamId)
unsigned int node, streamId;

{
	unsigned int ctxCnt, presCtxCnt;
	nodeStreamIdPtrType nodeStreamIdPtr, ctxCntNodeStreamIdPtr;
	nodeStreamIdPtrType presCtxCntNodeStreamIdPtr;
	nodeStreamIdPtrType stackNodeStreamIdPtr;
	char *QDataPtr;
	int i, found;

	/* Loop for all different transaction Qs. */
	for (i = 0; i < 5; i++)
	{
		nodeStreamIdPtr = FindGblIdxNodeStreamIdPtr (node, streamId, i);

		/* Currently handling a context? */
		if (nodeStreamIdPtr -> QCtxPtr)
		{
			/* Find the context count pointer for a particular streamId. */
			if ((ctxCntNodeStreamIdPtr = (FindNodeStreamIdPtr (
				nodeStreamIdPtr -> QCtxPtr -> ctxCntNodeStreamIdPtr, 0,
				streamId))))
			{
				/* Get streamId context count and decrement it. */
                ctxCnt = (unsigned int)((char*)(ctxCntNodeStreamIdPtr->otherDataPtr) - (char*)0);
				if (ctxCnt)
					ctxCntNodeStreamIdPtr -> otherDataPtr = (char *)0 + --ctxCnt;

				/* Check all streamId context counts.  If all are <= current
					streamId countext count, then pop context. */
				found = false;
				presCtxCntNodeStreamIdPtr = nodeStreamIdPtr -> QCtxPtr ->
					ctxCntNodeStreamIdPtr;
				while (presCtxCntNodeStreamIdPtr && ! found)
				{
                    presCtxCnt = (unsigned int)((char*)(presCtxCntNodeStreamIdPtr->otherDataPtr) - (char*)0);

					/* If all counts <= current count, found == false. */
					if (presCtxCnt > ctxCnt)
						found = true;
					else
						presCtxCntNodeStreamIdPtr = presCtxCntNodeStreamIdPtr ->
							next;
				}

				/* Pop context. */
				if (! found)
				{
io_printf ("Pop context.i=%d\n", i);
					/* Update node countext count. */
					if (nodeStreamIdPtr -> QCtxPtr -> ctxCnt)
						(nodeStreamIdPtr -> QCtxPtr -> ctxCnt)--;

					/* Find the stack pointer for the node context count. */
					if ((stackNodeStreamIdPtr = (FindNodeStreamIdPtr (
						nodeStreamIdPtr -> QCtxPtr -> stackNodeStreamIdPtr,
						0, nodeStreamIdPtr -> QCtxPtr -> ctxCnt))))
					{
						/* Transfer elements off stack element to current Q. */
						while ((QDataPtr = (PopQ1 (&(stackNodeStreamIdPtr ->
							QPtr)))))
							PushQ1 (&(nodeStreamIdPtr -> QPtr), QDataPtr);
					
					}
				}
			}
		}	
	}

}

/*----------------------------------------------------------*/
/* SaveTransactionCtx (node, streamId); */

void
SaveTransactionCtx (node, streamId)
unsigned int node, streamId;

{
	unsigned int ctxCnt;
	nodeStreamIdPtrType nodeStreamIdPtr, ctxCntNodeStreamIdPtr;
	nodeStreamIdPtrType stackNodeStreamIdPtr;
	int i;

	/* Loop for all different transaction Qs. */
	for (i = 0; i < 5; i++)
	{
		nodeStreamIdPtr = FindGblIdxNodeStreamIdPtr (node, streamId, i);

		/* If not already set up, create a context pointer. */
		if (! nodeStreamIdPtr -> QCtxPtr)
		{
			nodeStreamIdPtr -> QCtxPtr = (QCtxPtrType) IniGenericPtr (sizeof 
				(QCtxStructType));
		}

		/* Find the context count pointer for a particular streamId. */
		ctxCntNodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
			&(nodeStreamIdPtr -> QCtxPtr -> ctxCntNodeStreamIdPtr), 0,
			streamId);

		/* Get streamId context count and increment it. */
        ctxCnt = (unsigned int)((char*)(ctxCntNodeStreamIdPtr->otherDataPtr) - (char*)0);
		ctxCntNodeStreamIdPtr -> otherDataPtr = (char *)0 + ++ctxCnt;

		/* If streamId context count greater than node context count,
			save current context.  (i.e. Whenever a single stream changes 
			context, push node context.) */
		if (ctxCnt > (nodeStreamIdPtr -> QCtxPtr -> ctxCnt))
		{
io_printf ("Push context.i=%d\n", i);
			/* Find the stack pointer for the node context count. */
			stackNodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
				&(nodeStreamIdPtr -> QCtxPtr -> stackNodeStreamIdPtr), 0,
				nodeStreamIdPtr -> QCtxPtr -> ctxCnt);

			/* Context changes are synchronized with the next
				PopTransactionQPLI call; however, current pops
				must continue to receive their data from the
				current Q until the context is synchronized. 
				Keep a pointer to the previous Q. */
			if (! nodeStreamIdPtr -> QCtxPtr -> oldQPtrValid)
			{
				nodeStreamIdPtr -> QCtxPtr -> oldQPtrNodeStreamIdPtr =
					stackNodeStreamIdPtr;
				nodeStreamIdPtr -> QCtxPtr -> oldQPtrValid = true;
			}

			/* Save current QPtr.   Put stack element on stack. */
			stackNodeStreamIdPtr -> QPtr = nodeStreamIdPtr -> QPtr;
			
			/* Current Q is now empty. */
			nodeStreamIdPtr -> QPtr = (QPtrType) null;

			/* Update node countext count. */
			(nodeStreamIdPtr -> QCtxPtr -> ctxCnt)++;
		}

	}
}

/*----------------------------------------------------------*/
/* This function gets called locally from PopTransactionQPLI. */
/* $PopTransactionCtxQ (node, &streamId, &saveNotRetrieve); */

int
PopTransactionCtxQ (node, streamId, saveNotRetrieve)
unsigned int node, *streamId, *saveNotRetrieve;

{
	unsigned int success = 0;
	nodeStreamIdPtrType nodeStreamIdPtr;
	transactionCtxQDataPtrType QDataPtr;

	/* Only search on node. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (
		gblTransactionCtxNodeStreamIdPtr, node, 0)) !=
		(nodeStreamIdPtrType) null)
	{
		if ((QDataPtr = (transactionCtxQDataPtrType) PopQ1 (&(nodeStreamIdPtr ->
			QPtr))) != (transactionCtxQDataPtrType) null)
		{
			*streamId = QDataPtr -> streamId;
			*saveNotRetrieve = QDataPtr -> saveNotRetrieve;

			free (QDataPtr);

			success = 1;
		}
	}

	return (success);
}

/*----------------------------------------------------------*/
/* Elements to this Q get popped during a PopTransactionQPLI call. */
/* $PushTransactionCtxQPLI (node, streamId, saveNotRetrieve); */

void
PushTransactionCtxQPLI ()

{
	unsigned int node, streamId, saveNotRetrieve;
	nodeStreamIdPtrType nodeStreamIdPtr;
	transactionCtxQDataPtrType QDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);
	saveNotRetrieve = acc_fetch_tfarg_int (3);

	/* Perform the save now.  Sync the retrieve with PopTransactionQPLI.
		Changing the context on a retrieve now may corrupt 
		the data of the current popping Q (pointed to by
		QCtxPtr -> oldQPtrNodeStreamIdPtr). */
	if (saveNotRetrieve)
		SaveTransactionCtx (node, streamId);

	/* Search on node. */
	nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
		&gblTransactionCtxNodeStreamIdPtr, node, 0);

	/* Save the transactionCtx information. */
	QDataPtr = (transactionCtxQDataPtrType) IniGenericPtr (sizeof 
		(transactionCtxQDataStructType));
	QDataPtr -> streamId = streamId;
	QDataPtr -> saveNotRetrieve = saveNotRetrieve;

	PushQ1 (&(nodeStreamIdPtr -> QPtr), (char *) QDataPtr);

	acc_close ();
}

/*----------------------------------------------------------*/
/* pending = $StatusTransactionQPLI (node); */

void
StatusTransactionQPLI ()
{
  unsigned int pending = 0, node;

  nodeStreamIdPtrType nodeStreamIdPtr;
  transactionQDataPtrType QDataPtr;

  /* Initialize access routines. */
  acc_initialize ();
  acc_configure (accDevelopmentVersion, ACC_VER);

  /* Get arguments. */
  node = acc_fetch_tfarg_int (1);

  /* Only search on node. */
  if ((nodeStreamIdPtr = FindNodeStreamIdPtr 
   (gblTransactionNodeStreamIdPtr, node, 0)) != (nodeStreamIdPtrType) null)
  {                
    if ((QDataPtr = (transactionQDataPtrType) StatusQ1 
     (&(nodeStreamIdPtr ->QPtr))) != (transactionQDataPtrType) null)
    {
      pending = 1;
    }
  }

  /* Return success as a function argument. */
  tf_putp (0, pending);

  acc_close ();
}

/*----------------------------------------------------------*/
/* $PopTransactionQPLI (node, &streamId, &adr, &rdNotWrt, &cmd, &wrdSize); */

void
PopTransactionQPLI ()

{
	unsigned int success = 0, node;
	unsigned int streamId, saveNotRetrieve;
	handle streamIdHdl, adrHdl, rdNotWrtHdl, cmdHdl, wrdSizeHdl;
	nodeStreamIdPtrType nodeStreamIdPtr;
	transactionQDataPtrType QDataPtr;
	static s_setval_delay delay_s = {{accRealTime}, accNoDelay};
	static s_setval_value value_s = {accIntVal};

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	/* Get arguments. */
	node = acc_fetch_tfarg_int (1);

	/* Get handles. */
	streamIdHdl = acc_handle_tfarg (2);
	adrHdl = acc_handle_tfarg (3);
	rdNotWrtHdl = acc_handle_tfarg (4);
	cmdHdl = acc_handle_tfarg (5);
	wrdSizeHdl = acc_handle_tfarg (6);


	/* Current transacton is complete, no longer need to
		worry about corrupting the Q pointed to by
		QCtxPtr -> oldQPtrNodeStreamIdPtr. */
	if (PopTransactionCtxQ (node, &streamId, &saveNotRetrieve))
    {
		if (! saveNotRetrieve)
        {
			RetrieveTransactionCtx (node, streamId);
        }
		else
        {
			/* Synchronize context switches on a transaction pop. 
				Context has already been saved. */
			SyncCtx (node, streamId);
        }
    }

	/* Only search on node. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblTransactionNodeStreamIdPtr,
		node, 0)) != (nodeStreamIdPtrType) null)
	{

		if ((QDataPtr = (transactionQDataPtrType) PopQ1 (&(nodeStreamIdPtr ->
			QPtr))) != (transactionQDataPtrType) null)
		{

			delay_s.time.real = 0;
			value_s.value.integer = QDataPtr -> streamId;
			acc_set_value (streamIdHdl, &value_s, &delay_s);

			value_s.value.integer = QDataPtr -> adr;
			acc_set_value (adrHdl, &value_s, &delay_s);

			value_s.value.integer = QDataPtr -> rdNotWrt;
			acc_set_value (rdNotWrtHdl, &value_s, &delay_s);

			value_s.value.integer = QDataPtr -> cmd;
			acc_set_value (cmdHdl, &value_s, &delay_s);

			value_s.value.integer = QDataPtr -> wrdSize;
			acc_set_value (wrdSizeHdl, &value_s, &delay_s);

			free (QDataPtr);

			success = 1;
		}
	}

	/* Return success as a function argument. */
	tf_putp (0, success);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PopTransaction64QPLI (node, &streamId, &adrHi, &adr, &rdNotWrt, &cmd, &wrdSize); */

void
PopTransaction64QPLI ()

{
      unsigned int success = 0, node;
      unsigned int streamId, saveNotRetrieve;
      handle streamIdHdl, adrHiHdl, adrHdl, rdNotWrtHdl, cmdHdl, wrdSizeHdl;
      nodeStreamIdPtrType nodeStreamIdPtr;
      transactionQDataPtrType QDataPtr;
      static s_setval_delay delay_s = {{accRealTime}, accNoDelay};
      static s_setval_value value_s = {accIntVal};

      /* Initialize access routines. */
      acc_initialize ();
      acc_configure (accDevelopmentVersion, ACC_VER);

      /* Get arguments. */
      node = acc_fetch_tfarg_int (1);

      /* Get handles. */
      streamIdHdl = acc_handle_tfarg (2);
      adrHiHdl = acc_handle_tfarg (3);
      adrHdl = acc_handle_tfarg (4);
      rdNotWrtHdl = acc_handle_tfarg (5);
      cmdHdl = acc_handle_tfarg (6);
      wrdSizeHdl = acc_handle_tfarg (7);


      /* Current transacton is complete, no longer need to
              worry about corrupting the Q pointed to by
              QCtxPtr -> oldQPtrNodeStreamIdPtr. */
      if (PopTransactionCtxQ (node, &streamId, &saveNotRetrieve)) {
        if (! saveNotRetrieve) {
          RetrieveTransactionCtx (node, streamId);
        } else {
          /* Synchronize context switches on a transaction pop. 
             Context has already been saved. */
          SyncCtx (node, streamId);
        }
      }
      
      /* Only search on node. */
      if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblTransactionNodeStreamIdPtr,
                                                  node, 0)) != (nodeStreamIdPtrType) null)
        {
          if ((QDataPtr = (transactionQDataPtrType) PopQ1 (&(nodeStreamIdPtr ->QPtr))) != (transactionQDataPtrType) null)
            {
              delay_s.time.real = 0;
              value_s.value.integer = QDataPtr -> streamId;
              acc_set_value (streamIdHdl, &value_s, &delay_s);
              
              value_s.value.integer = QDataPtr -> adrHi;
              acc_set_value (adrHiHdl, &value_s, &delay_s);
              
              value_s.value.integer = QDataPtr -> adr;
              acc_set_value (adrHdl, &value_s, &delay_s);
              
              value_s.value.integer = QDataPtr -> rdNotWrt;
              acc_set_value (rdNotWrtHdl, &value_s, &delay_s);
              
              value_s.value.integer = QDataPtr -> cmd;
              acc_set_value (cmdHdl, &value_s, &delay_s);
              
              value_s.value.integer = QDataPtr -> wrdSize;
              acc_set_value (wrdSizeHdl, &value_s, &delay_s);
              
              free (QDataPtr);
              
              success = 1;
            }
        }
      
      /* Return success as a function argument. */
      tf_putp (0, success);
      
      acc_close ();
}


/*----------------------------------------------------------*/

/*----------------------------------------------------------*/
/* $PushTransactionQPLI (node, streamId, adr, rdNotWrt, cmd, wrdSize); */

void
PushTransactionQPLI ()

{
	unsigned int node, streamId, adr, rdNotWrt, cmd, wrdSize;
	nodeStreamIdPtrType nodeStreamIdPtr;
	transactionQDataPtrType QDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);
	adr = acc_fetch_tfarg_int (3);
	rdNotWrt = acc_fetch_tfarg_int (4);
	cmd = acc_fetch_tfarg_int (5);
	wrdSize = acc_fetch_tfarg_int (6);

	/* Only search on node. */
	nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
		&gblTransactionNodeStreamIdPtr, node, 0);

	/* Save the read information. */
	QDataPtr = (transactionQDataPtrType) IniGenericPtr (sizeof 
		(transactionQDataStructType));
	QDataPtr -> streamId = streamId;
	QDataPtr -> adr = adr;
	QDataPtr -> rdNotWrt = rdNotWrt;
	QDataPtr -> cmd = cmd;
	QDataPtr -> wrdSize = wrdSize;

	/* Push data on proper Q. */
	PushQCtx (streamId, nodeStreamIdPtr, (char *) QDataPtr);

	acc_close ();
}

/* $PushTransaction64QPLI (node, streamId, adrHi, adr, rdNotWrt, cmd, wrdSize); */

void
PushTransaction64QPLI ()
{
      unsigned int node, streamId, adrHi, adr, rdNotWrt, cmd, wrdSize;
      nodeStreamIdPtrType nodeStreamIdPtr;
      transactionQDataPtrType QDataPtr;

      /* Initialize access routines. */
      acc_initialize ();
      acc_configure (accDevelopmentVersion, ACC_VER);

      node = acc_fetch_tfarg_int (1);
      streamId = acc_fetch_tfarg_int (2);
      adrHi = acc_fetch_tfarg_int (3);
      adr = acc_fetch_tfarg_int (4);
      rdNotWrt = acc_fetch_tfarg_int (5);
      cmd = acc_fetch_tfarg_int (6);
      wrdSize = acc_fetch_tfarg_int (7);

      /* Only search on node. */
      nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
              &gblTransactionNodeStreamIdPtr, node, 0);

      /* Save the read information. */
      QDataPtr = (transactionQDataPtrType) IniGenericPtr (sizeof 
              (transactionQDataStructType));
      QDataPtr -> streamId = streamId;
      QDataPtr -> adrHi = adrHi;
      QDataPtr -> adr = adr;
      QDataPtr -> rdNotWrt = rdNotWrt;
      QDataPtr -> cmd = cmd;
      QDataPtr -> wrdSize = wrdSize;

      /* Push data on proper Q. */
      PushQCtx (streamId, nodeStreamIdPtr, (char *) QDataPtr);

      acc_close ();
}

/*----------------------------------------------------------*/
/* $PopWrtDataQPLI (node, streamId, &data, &be_); */

void
PopWrtDataQPLI ()

{
	unsigned int success = 0, node, streamId;
	handle dataHdl, beHdl_;
	nodeStreamIdPtrType nodeStreamIdPtr;
	wrtDataQDataPtrType QDataPtr;
	static s_setval_delay delay_s = {{accRealTime}, accNoDelay};
	static s_setval_value value_s = {accIntVal};

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	/* Get arguments. */
	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);

	/* Get handles. */
	dataHdl = acc_handle_tfarg (3);
	beHdl_ = acc_handle_tfarg (4);

	/* Search on node and streamId. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblWrtDataNodeStreamIdPtr,
		node, streamId)) != (nodeStreamIdPtrType) null)
	{
		if ((QDataPtr = (wrtDataQDataPtrType) PopQCtx (nodeStreamIdPtr))
			!= (wrtDataQDataPtrType) null)
		{
			delay_s.time.real = 0;
			value_s.value.integer = QDataPtr -> data;
			acc_set_value (dataHdl, &value_s, &delay_s);

			value_s.value.integer = QDataPtr -> be_;
			acc_set_value (beHdl_, &value_s, &delay_s);

			free (QDataPtr);

			success = 1;
		}
	}

	/* Return success as a function argument. */
	tf_putp (0, success);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PushWrtDataQPLI (node, streamId, data, be_); */

void
PushWrtDataQPLI ()

{
	unsigned int node, streamId, data, be_;
	nodeStreamIdPtrType nodeStreamIdPtr;
	wrtDataQDataPtrType QDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);
	data = acc_fetch_tfarg_int (3);
	be_ = acc_fetch_tfarg_int (4);

	/* Search on node and streamId. */
	nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
		&gblWrtDataNodeStreamIdPtr, node, streamId);

	/* Save the read information. */
	QDataPtr = (wrtDataQDataPtrType) IniGenericPtr (sizeof 
		(wrtDataQDataStructType));
	QDataPtr -> data = data;
	QDataPtr -> be_ = be_;

	/* Push data on proper Q. */
	PushQCtx (streamId, nodeStreamIdPtr, (char *) QDataPtr);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $TranferWrtDataQPLI (srcNode, streamId, dstNode, numWrds); */

void
TransferWrtDataQPLI ()

{
	unsigned int srcNode, streamId, dstNode, numWrds;
	unsigned int success = 0;
	nodeStreamIdPtrType srcNodeStreamIdPtr, dstNodeStreamIdPtr;
	wrtDataQDataPtrType QDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	srcNode = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);
	dstNode = acc_fetch_tfarg_int (3);
	numWrds = acc_fetch_tfarg_int (4);

	/* Data to execute on? */
	if (numWrds)
	{
		/* Find srcNode,streamId wrtData Q ptr. */
		if ((srcNodeStreamIdPtr = FindNodeStreamIdPtr (
			gblWrtDataNodeStreamIdPtr, srcNode, streamId)) !=
			(nodeStreamIdPtrType) null)
		{
			/* Find dstNode,streamId wrtData Q ptr. */
			dstNodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
				&gblWrtDataNodeStreamIdPtr, dstNode, streamId);

			while (numWrds)
			{
				/* Pop data from src and push data to dst. */
				if ((QDataPtr = (wrtDataQDataPtrType) PopQ1 (
					&(srcNodeStreamIdPtr -> QPtr))) !=
					(wrtDataQDataPtrType) null)
				{
					PushQ1 (&(dstNodeStreamIdPtr -> QPtr), (char *) QDataPtr);
				}

				/* If words count is zero, success. */
				if (! --numWrds)
					success = 1;
			}
		}
	}

	/* Return success as a function argument. */
	tf_putp (0, success);

	acc_close ();
}

/*----------------------------------------------------------*/
/* pending = $StatusRdDataQPLI (node); */

void
StatusRdDataQPLI ()
{
  unsigned int pending = 0, node;

  nodeStreamIdPtrType nodeStreamIdPtr;
  rdDataQDataPtrType QDataPtr;

  /* Initialize access routines. */
  acc_initialize ();
  acc_configure (accDevelopmentVersion, ACC_VER);

  /* Get arguments. */
  node     = acc_fetch_tfarg_int (1);

  /* Only search on node. */
  if ((nodeStreamIdPtr = FindNodeStreamIdPtr 
   (gblRdDataNodeStreamIdPtr, node, 0)) != (nodeStreamIdPtrType) null)
  {                
    if ((QDataPtr = (rdDataQDataPtrType) StatusQ1 
     (&(nodeStreamIdPtr ->QPtr))) != (rdDataQDataPtrType) null)
    {
      pending = 1;
    }
  }

  /* Return success as a function argument. */
  tf_putp (0, pending);

  acc_close ();
}

/*----------------------------------------------------------*/
/* $PopRdDataQPLI (node, streamId, &data); */

void
PopRdDataQPLI ()

{
	unsigned int success = 0, node, streamId;
	handle dataHdl;
	nodeStreamIdPtrType nodeStreamIdPtr;
	rdDataQDataPtrType QDataPtr;
	static s_setval_delay delay_s = {{accRealTime}, accNoDelay};
	static s_setval_value value_s = {accIntVal};

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	/* Get arguments. */
	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);

	/* Get handles. */
	dataHdl = acc_handle_tfarg (3);

	/* Search on node and streamId. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblRdDataNodeStreamIdPtr,
		node, streamId)) != (nodeStreamIdPtrType) null)
	{
		if ((QDataPtr = (rdDataQDataPtrType) PopQCtx (nodeStreamIdPtr))
			!= (rdDataQDataPtrType) null)
		{
			delay_s.time.real = 0;
			value_s.value.integer = QDataPtr -> data;
			acc_set_value (dataHdl, &value_s, &delay_s);

			free (QDataPtr);

			success = 1;
		}
	}

	/* Return success as a function argument. */
	tf_putp (0, success);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PushRdDataQPLI (node, streamId, data); */

void
PushRdDataQPLI ()

{
	unsigned int node, streamId, data;
	nodeStreamIdPtrType nodeStreamIdPtr;
	rdDataQDataPtrType QDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);
	data = acc_fetch_tfarg_int (3);

	/* Search on node and streamId. */
	nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
		&gblRdDataNodeStreamIdPtr, node, streamId);

	/* Save the read information. */
	QDataPtr = (rdDataQDataPtrType) IniGenericPtr (sizeof 
		(rdDataQDataStructType));
	QDataPtr -> data = data;

	/* Push data on proper Q. */
	PushQCtx (streamId, nodeStreamIdPtr, (char *) QDataPtr);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PopRdDoneQPLI (node, streamId, &wrdSize); */

void
PopRdDoneQPLI ()

{
	unsigned int success = 0, node, streamId;
	handle wrdSizeHdl;
	nodeStreamIdPtrType nodeStreamIdPtr;
	rdDoneQDataPtrType QDataPtr;
	static s_setval_delay delay_s = {{accRealTime}, accNoDelay};
	static s_setval_value value_s = {accIntVal};

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	/* Get arguments. */
	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);

	/* Get handles. */
	wrdSizeHdl = acc_handle_tfarg (3);

	/* Search on node and streamId. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblRdDoneNodeStreamIdPtr,
		node, streamId)) != (nodeStreamIdPtrType) null)
	{
		if ((QDataPtr = (rdDoneQDataPtrType) PopQCtx (nodeStreamIdPtr))
			!= (rdDoneQDataPtrType) null)
		{
			delay_s.time.real = 0;
			value_s.value.integer = QDataPtr -> wrdSize;
			acc_set_value (wrdSizeHdl, &value_s, &delay_s);

			free (QDataPtr);

			success = 1;
		}
	}

	/* Return success as a function argument. */
	tf_putp (0, success);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PushRdDoneQPLI (node, streamId, wrdSize); */

void
PushRdDoneQPLI ()

{
	unsigned int node, streamId, wrdSize;
	nodeStreamIdPtrType nodeStreamIdPtr;
	rdDoneQDataPtrType QDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);
	wrdSize = acc_fetch_tfarg_int (3);

	/* Search on node and streamId. */
	nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
		&gblRdDoneNodeStreamIdPtr, node, streamId);

	/* Save the read information. */
	QDataPtr = (rdDoneQDataPtrType) IniGenericPtr (sizeof 
		(rdDoneQDataStructType));
	QDataPtr -> wrdSize = wrdSize;

	/* Push data on proper Q. */
	PushQCtx (streamId, nodeStreamIdPtr, (char *) QDataPtr);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PopRdReqQPLI (node, streamId, &wrdSize); */

void
PopRdReqQPLI ()

{
	unsigned int success = 0, node, streamId;
	handle wrdSizeHdl;
	nodeStreamIdPtrType nodeStreamIdPtr;
	rdReqQDataPtrType QDataPtr;
	static s_setval_delay delay_s = {{accRealTime}, accNoDelay};
	static s_setval_value value_s = {accIntVal};

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	/* Get arguments. */
	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);

	/* Get handles. */
	wrdSizeHdl = acc_handle_tfarg (3);

	/* Search on node and streamId. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblRdReqNodeStreamIdPtr,
		node, streamId)) != (nodeStreamIdPtrType) null)
	{
		if ((QDataPtr = (rdReqQDataPtrType) PopQCtx (nodeStreamIdPtr))
			!= (rdReqQDataPtrType) null)
		{
			delay_s.time.real = 0;
			value_s.value.integer = QDataPtr -> wrdSize;
			acc_set_value (wrdSizeHdl, &value_s, &delay_s);

			free (QDataPtr);

			success = 1;
		}
	}

	/* Return success as a function argument. */
	tf_putp (0, success);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PushRdReqQPLI (node, streamId, wrdSize); */

void
PushRdReqQPLI ()

{
	unsigned int node, streamId, wrdSize;
	nodeStreamIdPtrType nodeStreamIdPtr;
	rdReqQDataPtrType QDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	node = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);
	wrdSize = acc_fetch_tfarg_int (3);

	/* Search on node and streamId. */
	nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
		&gblRdReqNodeStreamIdPtr, node, streamId);

	/* Save the read information. */
	QDataPtr = (rdReqQDataPtrType) IniGenericPtr (sizeof 
		(rdReqQDataStructType));
	QDataPtr -> wrdSize = wrdSize;

	/* Push data on proper Q. */
	PushQCtx (streamId, nodeStreamIdPtr, (char *) QDataPtr);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PopWaitQPLI (type, &streamId, &clks); */

void
PopWaitQPLI ()

{
	unsigned int success = 0, type;
	handle streamIdHdl, clksHdl;
	nodeStreamIdPtrType nodeStreamIdPtr;
	waitQDataPtrType QDataPtr;
	static s_setval_delay delay_s = {{accRealTime}, accNoDelay};
	static s_setval_value value_s = {accIntVal};

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	/* Get arguments. */
	type = acc_fetch_tfarg_int (1);

	/* Get handles. */
	streamIdHdl = acc_handle_tfarg (2);
	clksHdl = acc_handle_tfarg (3);

	/* Only search on type. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblWaitNodeStreamIdPtr,
		type, 0)) != (nodeStreamIdPtrType) null)
	{
		if ((QDataPtr = (waitQDataPtrType) PopQ1 (&(nodeStreamIdPtr ->
			QPtr))) != (waitQDataPtrType) null)
		{
			delay_s.time.real = 0;
			value_s.value.integer = QDataPtr -> streamId;
			acc_set_value (streamIdHdl, &value_s, &delay_s);

			value_s.value.integer = QDataPtr -> clks;
			acc_set_value (clksHdl, &value_s, &delay_s);

			free (QDataPtr);

			success = 1;
		}
	}

	/* Return success as a function argument. */
	tf_putp (0, success);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PushWaitQPLI (type, streamId, clks); */

void
PushWaitQPLI ()

{
	unsigned int type, streamId, clks;
	nodeStreamIdPtrType nodeStreamIdPtr;
	waitQDataPtrType QDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	type = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);
	clks = acc_fetch_tfarg_int (3);

	/* Search on node and streamId. */
	nodeStreamIdPtr = FindOrCreateNodeStreamIdPtr (
		&gblWaitNodeStreamIdPtr, type, 0);

	/* Save the read information. */
	QDataPtr = (waitQDataPtrType) IniGenericPtr (sizeof 
		(waitQDataStructType));
	QDataPtr -> streamId = streamId;
	QDataPtr -> clks = clks;

	PushQ1 (&(nodeStreamIdPtr -> QPtr), (char *) QDataPtr);

	acc_close ();
}

/*----------------------------------------------------------*/
/* cnt = $GetSyncCntPLI (type); */

void
GetSyncCntPLI ()

{
	unsigned int type, syncCnt;
	nodeStreamIdPtrType nodeStreamIdPtr;
	syncOtherDataPtrType syncOtherDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	/* Get arguments. */
	type = acc_fetch_tfarg_int (1);

	/* Search on type. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblSyncCntNodeStreamIdPtr,
		type, 0)) != (nodeStreamIdPtrType) null)
	{
		syncOtherDataPtr = (syncOtherDataPtrType) nodeStreamIdPtr ->
			otherDataPtr;
		syncCnt = syncOtherDataPtr -> syncCnt;
	}
	else
		syncCnt = 0;

	/* Return clks as a function argument. */
	tf_putp (0, syncCnt);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PutSyncCntPLI (type, syncCnt); */

void
PutSyncCntPLI ()

{
	unsigned int type, syncCnt;
	nodeStreamIdPtrType nodeStreamIdPtr;
	syncOtherDataPtrType syncOtherDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	type = acc_fetch_tfarg_int (1);
	syncCnt = acc_fetch_tfarg_int (2);

	/* Search on type. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblSyncCntNodeStreamIdPtr,
		type, 0)) == (nodeStreamIdPtrType) null)
	{
		nodeStreamIdPtr = IniNodeStreamIdPtr ();
		syncOtherDataPtr =  (syncOtherDataPtrType) IniGenericPtr (
			sizeof (syncOtherDataStructType));

		nodeStreamIdPtr -> node = type;
		nodeStreamIdPtr -> streamId = 0;
		nodeStreamIdPtr -> otherDataPtr = (char *) syncOtherDataPtr;

		/* Link in one nodeStreamIdPtr structure. */
		nodeStreamIdPtr -> next = gblSyncCntNodeStreamIdPtr;
		gblSyncCntNodeStreamIdPtr = nodeStreamIdPtr;
	}

	/* Save the data element. */
	syncOtherDataPtr = (syncOtherDataPtrType) nodeStreamIdPtr ->
		otherDataPtr;
	syncOtherDataPtr -> syncCnt = syncCnt;

	acc_close ();
}

/*----------------------------------------------------------*/
/* syncFlag = $GetSyncFlagPLI (type, streamId); */

void
GetSyncFlagPLI ()

{
	unsigned int type, streamId, syncFlag;
	nodeStreamIdPtrType nodeStreamIdPtr;
	syncOtherDataPtrType syncOtherDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	/* Get arguments. */
	type = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);

	/* Search on type. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblSyncFlagNodeStreamIdPtr,
		type, streamId)) != (nodeStreamIdPtrType) null)
	{
		syncOtherDataPtr = (syncOtherDataPtrType) nodeStreamIdPtr ->
			otherDataPtr;
		syncFlag = syncOtherDataPtr -> syncFlag;
	}
	else
		syncFlag = 0;

	/* Return clks as a function argument. */
	tf_putp (0, syncFlag);

	acc_close ();
}

/*----------------------------------------------------------*/
/* $PutSyncFlagPLI (type, streamId, syncFlag); */

void
PutSyncFlagPLI ()

{
	unsigned int type, streamId, syncFlag;
	nodeStreamIdPtrType nodeStreamIdPtr;
	syncOtherDataPtrType syncOtherDataPtr;

	/* Initialize access routines. */
	acc_initialize ();
	acc_configure (accDevelopmentVersion, ACC_VER);

	type = acc_fetch_tfarg_int (1);
	streamId = acc_fetch_tfarg_int (2);
	syncFlag = acc_fetch_tfarg_int (3);

	/* Search on type. */
	if ((nodeStreamIdPtr = FindNodeStreamIdPtr (gblSyncFlagNodeStreamIdPtr,
		type, streamId)) == (nodeStreamIdPtrType) null)
	{
		nodeStreamIdPtr = IniNodeStreamIdPtr ();
		syncOtherDataPtr =  (syncOtherDataPtrType) IniGenericPtr (
			sizeof (syncOtherDataStructType));

		nodeStreamIdPtr -> node = type;
		nodeStreamIdPtr -> streamId = streamId;
		nodeStreamIdPtr -> otherDataPtr = (char *) syncOtherDataPtr;

		/* Link in one nodeStreamIdPtr structure. */
		nodeStreamIdPtr -> next = gblSyncFlagNodeStreamIdPtr;
		gblSyncFlagNodeStreamIdPtr = nodeStreamIdPtr;
	}

	/* Save the data element. */
	syncOtherDataPtr = (syncOtherDataPtrType) nodeStreamIdPtr ->
		otherDataPtr;
	syncOtherDataPtr -> syncFlag = syncFlag;

	acc_close ();
}

