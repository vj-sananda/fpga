<?xml version="1.0" standalone="no"?>
<xsl:stylesheet version="1.0"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           xmlns:exsl="http://exslt.org/common"
           xmlns:xlink="http://www.w3.org/1999/xlink">
                
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
	       doctype-public="-//W3C//DTD SVG 1.0//EN"
		   doctype-system="http://www.w3.org/TR/SVG/DTD/svg10.dtd"/>


<xsl:param name="MSHP_IP_H"      select="64"/>				
<xsl:param name="MSHP_IP_W"      select="96"/>
<xsl:param name="MSHP_IP_Y_GAP"  select="4"/>

<xsl:param name="MSHP_MEM_W"     select="($MSHP_IP_W * 3)"/>				
<xsl:param name="MSHP_MEM_H"     select="($MSHP_IP_H * 2) + 22"/>				

<xsl:param name="MSHP_ARROW_H"   select="8"/>
<xsl:param name="MSHP_ARROW_W"   select="8"/>
<xsl:param name="MSHP_HCONNE_L"  select="ceiling($MSHP_IP_W div 2)"/>
<xsl:param name="MSHP_VCONNE_L"  select="ceiling($MSHP_IP_H div 2)"/>

<xsl:param name="MSHP_COL_MEM"      select="'#999999'"/>	
<xsl:param name="MSHP_COL_LMBBUS"   select="$BLKD_COL_LMBBUS"/>	
<xsl:param name="MSHP_COL_LMBCNTL"  select="'#8080FF'"/>	

<!-- ======================= MAIN BLOCK =============================== -->
<xsl:template name="Layout_ProcMemDefs">
	
	<xsl:for-each select="RENDERINFO/MEMSHAPE[@BUSDOMAIN_IS_LMB='TRUE']">
			<xsl:call-template name="Layout_LMBMemDefs"/>
	</xsl:for-each>
	
</xsl:template>

<xsl:template name="Layout_LMBMemDefs">
	
	<symbol id="MSHP_LMBArrowEast">
		<path class="bus"
			  d="M   0,0
				 L     {$MSHP_ARROW_W}, {ceiling($MSHP_ARROW_H div 2)}
				 L   0,{$MSHP_ARROW_H}, 
				 Z" style="stroke:none; fill:{$MSHP_COL_LMBBUS}"/>
	</symbol>
	
	<symbol id="MSHP_LMBArrowNorth">
		<path class="bus"
			  d="M   0,0
				 L   {$MSHP_ARROW_W},0
				 L   {ceiling($MSHP_ARROW_W div 2)}, {$MSHP_ARROW_H}
				 Z" style="stroke:none; fill:{$MSHP_COL_LMBBUS}"/>
	</symbol>
	
	<symbol id="MSHP_LMBConnI">
		<rect  x="4" y="3" width= "{$MSHP_HCONNE_L}" height="2" style="fill:{$MSHP_COL_LMBBUS};"/>
		<use   x="{$MSHP_HCONNE_L}"  y="0"  xlink:href="#MSHP_LMBArrowEast"/>	
		<rect  x="3" y="3" height="{$MSHP_VCONNE_L}" width="2"  style="fill:{$MSHP_COL_LMBBUS};"/>
		<use   y="{$MSHP_VCONNE_L}"  x="0"  xlink:href="#MSHP_LMBArrowNorth"/>	
	</symbol>
	
	<symbol id="MSHP_LMBConnD">
		<use   y="0"  x="0"  xlink:href="#MSHP_LMBConnI" transform="scale(-1,1) translate({(($MSHP_HCONNE_L + $MSHP_ARROW_W) * -1)},0)"/>	
	</symbol>
	
	<symbol id="MSHP_ICON_MemCntlrI">
	  <image x="0" y="0"  width="32" height="32" xlink:href="ICON_MemCntlr.gif"/> 
	</symbol>
	
	<symbol id="MSHP_ICON_MemCntlrD">
		<use  x="0"  y="0"  xlink:href="#MSHP_ICON_MemCntlrI" transform="scale(-1,1) translate(-32,0)"/>
	</symbol>
	
	<!-- LMB Processor Memory Block -->
	
	<symbol id="PROC_Memory" overflow="visible">	
		
	<!-- DLMB Memory controller -->
	<rect  x="0"  
		   y="{$MSHP_IP_H + 4}"
		   rx="3" ry="3" 
		   width ="{$MSHP_IP_W}" 
		   height="{$MSHP_IP_H}" style="fill:{$MSHP_COL_LMBCNTL}; fill-opacity: 0.8; stroke: rgb(0,0,0); stroke-width:1"/> 
		   
    <use   x="{                ceiling(($MSHP_IP_W div 2)) - 16}" 
		   y="{$MSHP_IP_H + $MSHP_IP_Y_GAP + ceiling(($MSHP_IP_H div 2)) - 16}" 
		   xlink:href="#MSHP_ICON_MemCntlrI"/> 

   	<text class="iptype"
          x="{ceiling(($MSHP_IP_W div 2))}"  
		  y="{$MSHP_IP_H + $MSHP_IP_Y_GAP  + 10}">
			<xsl:value-of select="@ICTYPE"/>
	</text>
	
	<text class="iplabel"
          x="{ceiling(($MSHP_IP_W div 2))}"  
		  y="{$MSHP_IP_H + $MSHP_IP_Y_GAP  + $MSHP_IP_H - 5}">
			<xsl:value-of select="@ICNAME"/>
	</text>  
	
    <use   x="{ceiling($MSHP_IP_W div 2) - $MSHP_ARROW_W}" 
		   y="{ceiling($MSHP_IP_H div 2) - 4}" 
		   xlink:href="#MSHP_LMBConnI"/> 
	
	<!-- DLMB Memory controller -->
	<rect  x="{$MSHP_MEM_W - $MSHP_IP_W}"  
		   y="{$MSHP_IP_H + $MSHP_IP_Y_GAP}"
		   rx="3" ry="3" 
		   width ="{$MSHP_IP_W}" 
		   height="{$MSHP_IP_H}" style="fill:{$MSHP_COL_LMBCNTL}; fill-opacity: 0.8; stroke: rgb(0,0,0); stroke-width:1"/> 
		   
     <use x="{$MSHP_MEM_W   - ceiling(($MSHP_IP_W div 2)) - 16}" 
		  y="{$MSHP_IP_H + $MSHP_IP_Y_GAP  + ceiling(($MSHP_IP_H div 2)) - 16}" 
		  xlink:href="#MSHP_ICON_MemCntlrD"/> 	   
		  
   	<text class="iptype"
          x="{$MSHP_MEM_W - ceiling(($MSHP_IP_W div 2))}"  
		  y="{$MSHP_IP_H + $MSHP_IP_Y_GAP  + 10}">
			<xsl:value-of select="@DCTYPE"/>
	</text>   
	
	<text class="iplabel"
          x="{$MSHP_MEM_W - ceiling(($MSHP_IP_W div 2))}"  
		  y="{$MSHP_IP_H + $MSHP_IP_Y_GAP  + $MSHP_IP_H - 5}">
				<xsl:value-of select="@DCNAME"/>
	</text>   
	
    <use   x="{$MSHP_MEM_W - $MSHP_IP_W}"
		   y="{ceiling($MSHP_IP_H div 2) - 4}" 
		   xlink:href="#MSHP_LMBConnD"/> 
	
	<!-- BRAM Block-->
	<rect  x="{ceiling(($MSHP_MEM_W - $MSHP_IP_W) div 2)}"  
		   y="0"
		   rx="3" ry="3" 
		   width ="{$MSHP_IP_W}" 
		   height="{$MSHP_IP_H}" style="fill:{$MSHP_COL_MEM}; fill-opacity: 0.8; stroke:{$MSHP_COL_LMBCNTL}; stroke-width:3"/> 
		   
	<image x="{ceiling($MSHP_MEM_W div 2) - 16}"  
		   y="{ceiling($MSHP_IP_H  div 2) - 16}"
		   width="32" height="32" xlink:href="ICON_BRam.gif"/> 	   
		   
	<text class="iptype"
			x="{ceiling($MSHP_MEM_W div 2)}"  
			y="12">
				<xsl:value-of select="@MEMTYPE"/>
	</text>   
	
	<text class="iplabel"
			x="{ceiling($MSHP_MEM_W div 2)}"  
			y="{$MSHP_IP_H - 4}">
				<xsl:value-of select="@MEMNAME"/>
	</text>  
 </symbol>
	
</xsl:template>

<xsl:template name="Draw_ProcessorMemory">

	<xsl:param name="x_pos" select="100"/>
	<xsl:param name="y_pos" select="100"/>
	
		<use  x="{$x_pos}"  y="{$y_pos}"   xlink:href="#PROC_Memory"/>	
	
</xsl:template>

<xsl:template name="Calc_ProcMem_H">
	<xsl:variable name="lmb_mem_cnt_" select="count(RENDERINFO/MEMSHAPE[@BUSDOMAIN_IS_LMB='TRUE'])"/>
	
	<xsl:variable name="lmb_mem_h_">
		<xsl:if test="$lmb_mem_cnt_ &gt; 0">
			<xsl:value-of select="$MSHP_MEM_H"/>
		</xsl:if>
		<xsl:if test="not($lmb_mem_cnt_ &gt; 0)">0</xsl:if>
	</xsl:variable>
	
	<xsl:value-of select="$lmb_mem_h_"/>
	
</xsl:template>

<xsl:template name="Calc_ProcMem_W">
	
	<xsl:variable name="lmb_mem_cnt_" select="count(RENDERINFO/MEMSHAPE[@BUSDOMAIN_IS_LMB='TRUE'])"/>
	
	<xsl:variable name="lmb_mem_w_">
		<xsl:if test="$lmb_mem_cnt_ &gt; 0">
			<xsl:value-of select="$MSHP_MEM_W"/>
		</xsl:if>
		<xsl:if test="not($lmb_mem_cnt_ &gt; 0)">0</xsl:if>
	</xsl:variable>
	
	<xsl:value-of select="$lmb_mem_w_"/>
	
</xsl:template>

<!-- ======================= END MAIN BLOCK =========================== -->

</xsl:stylesheet>
