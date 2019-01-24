<?xml version="1.0" standalone="no"?>
<xsl:stylesheet version="1.0"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           xmlns:exsl="http://exslt.org/common"
           xmlns:xlink="http://www.w3.org/1999/xlink">
                
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
	       doctype-public="-//W3C//DTD SVG 1.0//EN"
		   doctype-system="http://www.w3.org/TR/SVG/DTD/svg10.dtd"/>
		   
<!--		   
<xsl:param name="INSTANCE"          select="'plb2opb_bridge_i'"/>				
<xsl:param name="INSTANCE"          select="'opb_bram_if_cntlr_1'"/>
<xsl:param name="INSTANCE"          select="'microblaze_0'"/>				
<xsl:param name="INSTANCE"          select="'opb_timer_0'"/>				
<xsl:param name="INSTANCE"          select="'microblaze_1'"/>				
-->
<xsl:param name="INSTANCE"          select="'microblaze_0'"/>				

<xsl:param name="MOD_H_GAP"         select="16"/>				
<xsl:param name="MOD_V_GAP"         select="16"/>

<xsl:param name="MOD_H_PORT_GAP"    select="16"/>				

<xsl:param name="MOD_CENTER_W"      select="180"/>

<xsl:param name="MOD_PRT_W"         select="8"/>
<xsl:param name="MOD_PRT_H"         select="8"/>
<xsl:param name="MOD_PRT_SY"        select="8"/>
<xsl:param name="MOD_PRT_SPC"       select="16"/>

<xsl:param name="MOD_BUSARROW_H"       select="32"/>	
<xsl:param name="MOD_BUSARROW_W"       select="28"/>
<xsl:param name="MOD_BUSCONNECT_GAP"   select="20"/>
<xsl:param name="MOD_BUSARROW_INDENT"  select="8"/>

<xsl:param name="MOD_CBUSARROW_H"       select="16"/>	
<xsl:param name="MOD_CBUSARROW_W"       select="16"/>
<xsl:param name="MOD_CBUSCONNECT_W"     select="8"/>

<xsl:param name="MOD_BIFARROW_W"       select="14"/>	
<xsl:param name="MOD_BIFARROW_H"       select="10"/>
<xsl:param name="MOD_BIFARROW_HL"      select="32"/>
<xsl:param name="MOD_BIFARROW_INDENT"  select="3"/>

<xsl:param name="MOD_BIF_H"            select="$MOD_BIFARROW_H"/>
<xsl:param name="MOD_BIF_W"            select="($MOD_BIFARROW_W *2) + $MOD_BIFARROW_HL"/>
	
<xsl:param name="MOD_COL_OPB"     select="'#339900'"/>				
<xsl:param name="MOD_COL_OPB_TXT" select="'#99FF00'"/>				

<xsl:param name="MOD_COL_PLB"     select="'#FF3300'"/>				
<xsl:param name="MOD_COL_PLB_TXT" select="'#FFBB00'"/>				

<xsl:param name="MOD_COL_LMB"     select="'#7777FF'"/>				
<xsl:param name="MOD_COL_LMB_TXT" select="'#DDDDFF'"/>	

<xsl:param name="MOD_COL_FSL"     select="'#CC00CC'"/>				
<xsl:param name="MOD_COL_FSL_TXT" select="'#FF77FF'"/>	

<xsl:param name="MOD_COL_TRS"     select="'#888888'"/>				
<xsl:param name="MOD_COL_TRS_TXT" select="'#FF88FF'"/>	

<xsl:param name="MOD_COL_DCR"     select="'#6699FF'"/>				
<xsl:param name="MOD_COL_DCR_TXT" select="'#BBDDFF'"/>	

<xsl:param name="MOD_COL_DSOCM"     select="'#0000DD'"/>				
<xsl:param name="MOD_COL_DSOCM_TXT" select="'#9999DD'"/>	

<xsl:param name="MOD_COL_ISOCM"     select="'#0000DD'"/>				
<xsl:param name="MOD_COL_ISOCM_TXT" select="'#9999DD'"/>	

<xsl:param name="MOD_COL_MBG"     select="'#F0F0F0'"/>				
<xsl:param name="MOD_COL_BLACK"   select="'#000000'"/>
<xsl:param name="MOD_COL_WHITE"   select="'#FFFFFF'"/>
<xsl:param name="MOD_COL_SPRT"    select="'#888888'"/>
<xsl:param name="MOD_COL_MPRT"    select="'#888888'"/>
<!--
<xsl:param name="MOD_COL_MPRT"    select="'#AAAAFF'"/>
-->

	        
<!-- ======================= main svg block =============================== -->

<xsl:template match="EDKPROJECT">
<xsl:for-each select="MHSINFO/MODULES/MODULE[@INSTANCE= $INSTANCE]">
	
	
<xsl:variable name="ports_left_cnt_" select="count(MPORT[@DIR='I' or @DIR = 'IO'])"/>	
<xsl:variable name="ports_rght_cnt_" select="count(MPORT[@DIR='O'])"/>	
	
<xsl:variable name="bifs_left_cnt_"  select="count(BUSINTERFACE[not(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='SLAVE'])"/>	
<xsl:variable name="bifs_rght_cnt_"  select="count(BUSINTERFACE[not(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='MASTER'])"/>	

<xsl:variable name="bifs_top_cnt_"   select="count(BUSINTERFACE[(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='SLAVE'])"/>	
<xsl:variable name="bifs_bot_cnt_"   select="count(BUSINTERFACE[(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='MASTER'])"/>	
	
<xsl:variable name="bifs_acrs_cnt_"  select="count(BUSINTERFACE[@BIFRANK ='TRANSPARENT'])"/>	

<xsl:variable name="bif_rght_w_">
	<xsl:if test="(($bifs_acrs_cnt_ &gt; 0) or ($bifs_rght_cnt_ &gt; 0))">
		<xsl:value-of select="$MOD_BIF_W"/>
	</xsl:if>
		
	<xsl:if test="(($bifs_acrs_cnt_ &lt; 1) and ($bifs_rght_cnt_ &lt; 1))">
		<xsl:value-of select="$MOD_H_GAP"/>
	</xsl:if>
		
</xsl:variable>
	
<xsl:variable name="bif_left_w_">
	<xsl:if test="(($bifs_acrs_cnt_ &gt; 0) or ($bifs_left_cnt_ &gt; 0))">
		<xsl:value-of select="$MOD_BIF_W"/>
	</xsl:if>
		
	<xsl:if test="(($bifs_acrs_cnt_ &lt; 1) and ($bifs_left_cnt_ &lt; 1))">
		<xsl:value-of select="$MOD_H_GAP"/>
	</xsl:if>
		
</xsl:variable>

<xsl:variable name="bif_top_h_">
	<xsl:if test="($bifs_top_cnt_ &gt; 0)">
		<xsl:value-of select="(($MOD_BUSARROW_H + $MOD_V_GAP) * $bifs_top_cnt_) + $MOD_BUSCONNECT_GAP"/>
	</xsl:if>
		
	<xsl:if test="($bifs_top_cnt_ &lt; 1)">
		<xsl:value-of select="$MOD_V_GAP"/>
	</xsl:if>
		
</xsl:variable>
	
<xsl:variable name="bif_bot_h_">
	<xsl:if test="($bifs_bot_cnt_ &gt; 0)">
		<xsl:value-of select="(($MOD_BUSARROW_H + $MOD_V_GAP) * $bifs_bot_cnt_) + $MOD_BUSCONNECT_GAP"/>
	</xsl:if>
		
	<xsl:if test="($bifs_bot_cnt_ &lt; 1)">
		<xsl:value-of select="$MOD_V_GAP"/>
	</xsl:if>
		
</xsl:variable>

<xsl:variable name="bif_p2p_h_">
	
	<xsl:if test="($bifs_left_cnt_ &gt; $bifs_rght_cnt_)">
		<xsl:value-of select="(($MOD_BIF_H + $MOD_PRT_SPC) * $bifs_left_cnt_) + (($MOD_BIF_H + $MOD_PRT_SPC) * $bifs_acrs_cnt_)"/>
	</xsl:if>
		
	<xsl:if test="($bifs_rght_cnt_ &gt;= $bifs_left_cnt_)">
		<xsl:value-of select="(($MOD_BIF_H + $MOD_PRT_SPC) * $bifs_rght_cnt_) + (($MOD_BIF_H + $MOD_PRT_SPC) * $bifs_acrs_cnt_)"/>
	</xsl:if>
		
</xsl:variable>

<!-- select and return the maximum between the two left and right of ports -->
<xsl:variable name="port_h_">
<xsl:choose>
	
	<xsl:when test="(($ports_left_cnt_ &lt; 2) and ($ports_rght_cnt_ &lt; 2))">
		<xsl:value-of select="(($MOD_PRT_H + $MOD_PRT_SPC) * 2) + $MOD_PRT_SY"/>
	</xsl:when>
	
	<!-- make sure the module is at least 2 port spaces high -->
	<xsl:when test="($ports_left_cnt_ &gt; $ports_rght_cnt_)">
		<xsl:value-of select="(($MOD_PRT_H + $MOD_PRT_SPC) * $ports_left_cnt_) + $MOD_PRT_SY"/>
	</xsl:when>
		
	<xsl:when test="($ports_rght_cnt_ &gt; $ports_left_cnt_)">
		<xsl:value-of select="(($MOD_PRT_H + $MOD_PRT_SPC) * $ports_rght_cnt_) + $MOD_PRT_SY"/>
	</xsl:when>
	
	<xsl:when test="($ports_left_cnt_ = $ports_rght_cnt_)">
		<xsl:value-of select="(($MOD_PRT_H + $MOD_PRT_SPC) * $ports_left_cnt_) + $MOD_PRT_SY"/>
	</xsl:when>
	
</xsl:choose>	
</xsl:variable>

<xsl:variable name="mod_h_">
	<xsl:value-of select="$bif_p2p_h_ + $port_h_ + $bif_top_h_ + $bif_bot_h_ + ($MOD_V_GAP * 2)"/>
</xsl:variable>

<xsl:variable name="mod_w_">
	<xsl:value-of select="$bif_rght_w_ + $bif_left_w_ + $MOD_CENTER_W"/>
</xsl:variable>

<!--
		<P2P><xsl:value-of select="$bif_p2p_h_"/></P2P>	
		<PORTH><xsl:value-of select="$port_h_"/></PORTH>	
		<BIFT><xsl:value-of select="$bif_top_h_"/></BIFT>	
		<BIFB><xsl:value-of select="$bif_bot_h_"/></BIFB>	
-->		

<svg width="{($MOD_H_GAP  * 2) + $mod_w_}" height="{($MOD_V_GAP * 2) + $mod_h_}">
	
	<!--specify a css for the file -->
	<xsl:processing-instruction name="xml-stylesheet">href="MdtXdsSVG_Render.css" type="text/css"</xsl:processing-instruction>
	
	<defs>
		
		<xsl:call-template name="Layout_BusDefs">
			<xsl:with-param name="bus_width" select="$mod_w_"/>
		</xsl:call-template>			
		
		<xsl:call-template name="Layout_BifDefs"/>
		
		
		<xsl:call-template name="Layout_BodyDefs">
			<xsl:with-param name="body_width"  select="$mod_w_"/>
			<xsl:with-param name="body_height" select="$mod_h_ - ($bif_top_h_ + $bif_bot_h_)"/>
			<xsl:with-param name="gap_rght"    select="$bif_rght_w_"/>
			<xsl:with-param name="gap_left"    select="$bif_left_w_"/>
		</xsl:call-template>			
			
	</defs>	
	
	<xsl:call-template name="Draw_Module">
		<xsl:with-param name="body_width"  select="$mod_w_"/>
		<xsl:with-param name="body_height" select="$mod_h_ - ($bif_top_h_ + $bif_bot_h_)"/>
		<xsl:with-param name="gap_ports"   select="$port_h_"/>
		<xsl:with-param name="gap_top"     select="$bif_top_h_"/>
		<xsl:with-param name="gap_bot"     select="$bif_bot_h_"/>
		<xsl:with-param name="gap_rght"    select="$bif_rght_w_"/>
		<xsl:with-param name="gap_left"    select="$bif_left_w_"/>
	</xsl:call-template>			
			
</svg>

</xsl:for-each>
</xsl:template>

<!-- ======================= main svg block =============================== -->


<!-- ======================= IP DIAGRAM DEF =============================== -->

<xsl:template name="Layout_BodyDefs">
	
	<xsl:param name="body_width"  select="0"/>
	<xsl:param name="body_height" select="0"/>
	<xsl:param name="body_bg_col" select="$MOD_COL_MBG"/>
	
	<xsl:param name="gap_top"     select="$MOD_V_GAP"/>
	<xsl:param name="gap_bot"     select="$MOD_V_GAP"/>
	<xsl:param name="gap_rght"    select="$MOD_H_GAP"/>
	<xsl:param name="gap_left"    select="$MOD_H_GAP"/>
	
	<symbol id="HCurve" overflow="visible">
		<path d="m 0  0, 
			 a 16 16, 0,0,0, 32,0,
			 z" style="fill:{$body_bg_col};fill-opacity:1;stroke:black;stroke-width:1.5"/>  
		 <line x1="0" y1="0" x2="32" y2="0" style="stroke:{$body_bg_col};stroke-width:3"/>
	</symbol> 	
	
	<symbol id="MOD_StandardBody">
			
		<rect x="0"  
			  y="0"    
			  width ="{$body_width}"  
			  height="{$body_height}"
			  style="fill:{$body_bg_col};  fill-opacity: 1.0; stroke:{$MOD_COL_BLACK}; stroke-width:1"/> 
				
		<rect x="{$gap_left}" 
			  y="{$MOD_V_GAP}"   
			  width="{ $body_width  - ($gap_left + $gap_rght)}"   
			  height="{$body_height - ($MOD_V_GAP * 2)}" 
			  style="fill:{$MOD_COL_WHITE}; fill-opacity: 1.0; stroke:{$MOD_COL_BLACK}; stroke-width:1.5"/> 	
			  
		<xsl:variable name="inner_w_" select="$body_width - ($gap_left + $gap_rght)"/>
		
		<use  x="{$gap_left + ceiling($inner_w_ div 2) - 16}" 
			  y="{$MOD_H_GAP}" 
			  xlink:href="#HCurve"/>
			  
				   
<!--				   
		<use  x="{ceiling($body_width div 2) - 16}" 
			  y="{$MOD_H_GAP}" 
			  xlink:href="#HCurve"/>
-->			  
			  
	
	</symbol>
	
	<symbol id="MOD_MPort">
		<rect width ="{$MOD_PRT_W}" 
			  height="{$MOD_PRT_H}" 
			  style="fill:{$MOD_COL_MPRT};stroke-width:1;stroke:black;"/>
	</symbol>	
		
	<symbol id="MOD_SPort">
		<line x1="0"            y1="0" 
			  x2="{$MOD_PRT_W}" y2="0" 
			  style="stroke:{$MOD_COL_SPRT};stroke-width:2;stroke-opacity:1"/>
	</symbol>
	
    <symbol id="MOD_PortClk">
		<line x1="0" y1="0" 
			  x2="7" y2="3" 
			  style="stroke:{$MOD_COL_BLACK};stroke-width:1;stroke-opacity:1"/>
		<line x1="7" y1="3" x2="0" y2="7" style="stroke:{$MOD_COL_BLACK};stroke-width:1;stroke-opacity:1"/>
	</symbol>	
	
</xsl:template>

<xsl:template name="Layout_BusDefs">
	<xsl:param name="bus_width"  select="($MOD_BUSARROW_W * 2)"/>
	
	
	<xsl:if test="BUSINTERFACE[@BUSDOMAIN='OPB']">
		<xsl:call-template name="Layout_BusDef">
			<xsl:with-param name="bus_width"   select="$bus_width"/>
			<xsl:with-param name="bus_dom"     select="'OPB'"/>
			<xsl:with-param name="bus_col"     select="$MOD_COL_OPB"/>
			<xsl:with-param name="bus_col_txt" select="$MOD_COL_OPB_TXT"/>
		</xsl:call-template>
	</xsl:if>
		
	<xsl:if test="BUSINTERFACE[@BUSDOMAIN='PLB']">
		<xsl:call-template name="Layout_BusDef">
			<xsl:with-param name="bus_width"   select="$bus_width"/>
			<xsl:with-param name="bus_dom"     select="'PLB'"/>
			<xsl:with-param name="bus_col"     select="$MOD_COL_PLB"/>
			<xsl:with-param name="bus_col_txt" select="$MOD_COL_PLB_TXT"/>
		</xsl:call-template>
	</xsl:if>
	
</xsl:template>

<xsl:template name="Layout_BifDefs">
	
	<xsl:if test="BUSINTERFACE[@BUSDOMAIN='LMB']">
		<xsl:call-template name="Layout_BifDef">
			<xsl:with-param name="bif_width"   select="(($MOD_BIFARROW_W * 2) + $MOD_BIFARROW_HL)"/>
			<xsl:with-param name="bif_dom"     select="'LMB'"/>
			<xsl:with-param name="bif_col"     select="$MOD_COL_LMB"/>
			<xsl:with-param name="bif_col_TXT" select="$MOD_COL_LMB_TXT"/>
		</xsl:call-template>
	</xsl:if>
		
	<xsl:if test="BUSINTERFACE[@BUSDOMAIN='FSL']">
		<xsl:call-template name="Layout_BifDef">
			<xsl:with-param name="bif_width"   select="(($MOD_BIFARROW_W * 2) + $MOD_BIFARROW_HL)"/>
			<xsl:with-param name="bif_dom"     select="'FSL'"/>
			<xsl:with-param name="bif_col"     select="$MOD_COL_FSL"/>
			<xsl:with-param name="bif_col_TXT" select="$MOD_COL_FSL_TXT"/>
		</xsl:call-template>
	</xsl:if>
	
	<xsl:if test="BUSINTERFACE[@BUSDOMAIN='DCR']">
		<xsl:call-template name="Layout_BifDef">
			<xsl:with-param name="bif_width"   select="(($MOD_BIFARROW_W * 2) + $MOD_BIFARROW_HL)"/>
			<xsl:with-param name="bif_dom"     select="'DCR'"/>
			<xsl:with-param name="bif_col"     select="$MOD_COL_DCR"/>
			<xsl:with-param name="bif_col_TXT" select="$MOD_COL_DCR_TXT"/>
		</xsl:call-template>
	</xsl:if>
	
	
	<xsl:if test="BUSINTERFACE[@BUSDOMAIN='DSOCM']">
		<xsl:call-template name="Layout_BifDef">
			<xsl:with-param name="bif_width"   select="(($MOD_BIFARROW_W * 2) + $MOD_BIFARROW_HL)"/>
			<xsl:with-param name="bif_dom"     select="'DSOCM'"/>
			<xsl:with-param name="bif_col"     select="$MOD_COL_DSOCM"/>
			<xsl:with-param name="bif_col_TXT" select="$MOD_COL_DSOCM_TXT"/>
		</xsl:call-template>
	</xsl:if>
	
	<xsl:if test="BUSINTERFACE[@BUSDOMAIN='ISOCM']">
		<xsl:call-template name="Layout_BifDef">
			<xsl:with-param name="bif_width"   select="(($MOD_BIFARROW_W * 2) + $MOD_BIFARROW_HL)"/>
			<xsl:with-param name="bif_dom"     select="'ISOCM'"/>
			<xsl:with-param name="bif_col"     select="$MOD_COL_ISOCM"/>
			<xsl:with-param name="bif_col_TXT" select="$MOD_COL_ISOCM_TXT"/>
		</xsl:call-template>
	</xsl:if>
	
	
	<xsl:if test="BUSINTERFACE[@BIFRANK='TRANSPARENT']">
		<xsl:call-template name="Layout_TRSDef">
			<xsl:with-param name="bif_width"   select="(($MOD_BIFARROW_W * 2) + $MOD_BIFARROW_HL)"/>
			<xsl:with-param name="bif_dom"     select="'TRS'"/>
			<xsl:with-param name="bif_col"     select="$MOD_COL_TRS"/>
			<xsl:with-param name="bif_col_TXT" select="$MOD_COL_TRS_TXT"/>
		</xsl:call-template>
	</xsl:if>
	
</xsl:template>

<xsl:template name="Layout_BusDef">
	<xsl:param name="bus_width"   select="($MOD_BUSARROW_W * 2)"/>
	<xsl:param name="bus_dom"     select="'OPB'"/>
	<xsl:param name="bus_col"     select="$MOD_COL_OPB"/>
	<xsl:param name="bus_col_txt" select="$MOD_COL_OPB_TXT"/>
	
	<xsl:variable name="bus_length_">
		<xsl:value-of select="($bus_width -	($MOD_BUSARROW_W * 2))"/>
	</xsl:variable>	
	
	<symbol id="MOD_{$bus_dom}_BusArrowEast">
		<path class="bus"
			  d="M 0  0, 
				 L {$MOD_BUSARROW_W} {ceiling($MOD_BUSARROW_H div 2)} 
				 L 0 {$MOD_BUSARROW_H} 
				 Z" style="stroke:none; fill:{$bus_col}; fill-opacity:1"/>
	</symbol>
	
	<symbol id="MOD_{$bus_dom}_CBusArrowSouth">
		<path class="bus"
			  d="M 0  0, 
				 L {$MOD_CBUSARROW_W} 0 
				 L {ceiling($MOD_CBUSARROW_W div 2)} {$MOD_CBUSARROW_H} 
				 Z" style="stroke:none; fill:{$bus_col}; fill-opacity:1"/>
	</symbol>
	
	 <symbol id="MOD_{$bus_dom}_BusArrowWest">
		<use   x="0"   y="0"  xlink:href="#MOD_{$bus_dom}_BusArrowEast" transform="scale(-1,1) translate({$MOD_BUSARROW_W * -1},0)"/>
	 </symbol> 
	 
	<symbol id="MOD_{$bus_dom}_BusBody">
		<use  x="0" 
			  y="0"  
			  xlink:href="#MOD_{$bus_dom}_BusArrowWest"/>
			  
		<use  x="{$MOD_BUSARROW_W + $bus_length_}" 
			  y="0"  
			  xlink:href="#MOD_{$bus_dom}_BusArrowEast"/>
		<rect  x="{$MOD_BUSARROW_W}"  
			   y="{$MOD_BUSARROW_INDENT}" 
			   width="{$bus_length_}"  
			   height="{$MOD_BUSARROW_H - ($MOD_BUSARROW_INDENT * 2)}"  
			   style="fill:{$bus_col}; fill-opacity:1; stroke:none"/> 
			   
		<text style="fill:{$bus_col_txt};
				stroke:none; 
				font-size:12pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{ceiling($bus_width div 2)}"
				y="{ceiling($MOD_BUSARROW_H div 2) + 6}">
		      <xsl:value-of select="$bus_dom"/>
		</text>	
			
	</symbol>
	 
</xsl:template>

<xsl:template name="Layout_BifDef">
	
	<xsl:param name="bif_width"   select="(($MOD_BIFARROW_W * 2) + $MOD_BIFARROW_HL)"/>
	<xsl:param name="bif_dom"     select="'LMB'"/>
	<xsl:param name="bif_col"     select="$MOD_COL_LMB"/>
	
	 <symbol id="MOD_{$bif_dom}_BifArrowEast">
		<path class="bif"
			  d="M   0    0, 
				 L      {$MOD_BIFARROW_W} {ceiling($MOD_BIFARROW_H div 2)} 
				 L   0  {$MOD_BIFARROW_H} 
				 Z" style="stroke:none; fill:{$bif_col}; fill-opacity:1"/>
	</symbol>
	
	 <symbol id="MOD_{$bif_dom}_BifArrowWest">
		<use   x="0"   y="0"  xlink:href="#MOD_{$bif_dom}_BifArrowEast" transform="scale(-1,1) translate({$MOD_BIFARROW_W * -1},0)"/>
	 </symbol> 
	 
	<symbol id="MOD_{$bif_dom}_BifBody">
		<use  x="0" 
			  y="0"  
			  xlink:href="#MOD_{$bif_dom}_BifArrowWest"/>
			  
		<use  x="{$MOD_BIFARROW_W + $MOD_BIFARROW_HL}" 
			  y="0"  
			  xlink:href="#MOD_{$bif_dom}_BifArrowEast"/>
			  
		<rect  x="{$MOD_BIFARROW_W}"  
			   y="{$MOD_BIFARROW_INDENT}" 
			   width= "{$MOD_BIFARROW_HL}"  
			   height="{$MOD_BIFARROW_H - ($MOD_BIFARROW_INDENT * 2)}"  
			   style="fill:{$bif_col}; fill-opacity:1; stroke:none"/> 
	</symbol>
	 
</xsl:template>

<xsl:template name="Layout_TRSDef">
	
	<xsl:param name="bif_width"   select="(($MOD_BIFARROW_W * 2) + $MOD_BIFARROW_HL)"/>
	<xsl:param name="bif_dom"     select="'TRS'"/>
	<xsl:param name="bif_col"     select="$MOD_COL_TRS"/>
	
	 <symbol id="MOD_TRS_BifArrowEast">
		<path class="bif"
			  d="M   0    0, 
				 L      {$MOD_BIFARROW_W} {ceiling($MOD_BIFARROW_H div 2)} 
				 L   0  {$MOD_BIFARROW_H} 
				 Z" style="stroke:none; fill:{$bif_col}; fill-opacity:1"/>
	</symbol>
	
	 
	<symbol id="MOD_{$bif_dom}_BifBody">
		<use  x="{$MOD_BIFARROW_W + $MOD_BIFARROW_HL}" 
			  y="0"  
			  xlink:href="#MOD_{$bif_dom}_BifArrowEast"/>
			  
		<rect  x="0"  
			   y="{$MOD_BIFARROW_INDENT}" 
			   width= "{$MOD_BIFARROW_HL + $MOD_BIFARROW_W}"  
			   height="{$MOD_BIFARROW_H - ($MOD_BIFARROW_INDENT * 2)}"  
			   style="fill:{$bif_col}; fill-opacity:1; stroke:none"/> 
	</symbol>
	 
</xsl:template>


<xsl:template name="Draw_Ports">
	<xsl:param name="body_width"   select="0"/>
	<xsl:param name="body_height"  select="0"/>
	
	<xsl:param name="gap_bot"      select="$MOD_V_GAP"/>
	<xsl:param name="gap_top"      select="$MOD_V_GAP"/>
	<xsl:param name="gap_rght"     select="$MOD_H_GAP"/>
	<xsl:param name="gap_left"     select="$MOD_H_GAP"/>
	
	
	<xsl:variable name="prt_ix_pos_">
		<xsl:value-of select="$MOD_H_GAP + $gap_left - $MOD_PRT_W"/>
	</xsl:variable>	
	
	<xsl:variable name="prt_ini_y_">
		<xsl:value-of select="$gap_top + $MOD_V_GAP + $MOD_PRT_SY"/>
	</xsl:variable>	
	
	<!-- layout the input ports-->
	<xsl:for-each select="MPORT[@DIR='I'or @DIR='IO']">
		<xsl:sort data-type="number" select="@PRTNUMBER" order="ascending"/>
		<xsl:variable name="prt_iy_pos_" select="$prt_ini_y_ + ((position() - 1) * ($MOD_PRT_SPC + $MOD_PRT_H))"/>
		
		<xsl:if test="@MSB and @LSB">
			<use x="{$prt_ix_pos_}" y="{$prt_iy_pos_}" xlink:href="#MOD_MPort"/>
		</xsl:if>
		<xsl:if test="not(@MSB) or not(@LSB)">
			<use x="{$prt_ix_pos_}" y="{$prt_iy_pos_}" xlink:href="#MOD_SPort"/>
		</xsl:if>
		<xsl:if test="@SIGIS='CLK'">
			<use x="{$prt_ix_pos_ + 8}" y="{$prt_iy_pos_ - 2}" xlink:href="#MOD_PortClk"/>
		</xsl:if>
		<text class="portlabel" 
		       x="{$prt_ix_pos_ + $MOD_PRT_W + 12}" 
			   y="{$prt_iy_pos_ + 6}"><xsl:value-of select="@PRTNUMBER"/></text>
	</xsl:for-each>
	
	<xsl:variable name="prt_ox_pos_">
		<xsl:value-of select="$MOD_H_GAP + $body_width - $gap_rght"/>
	</xsl:variable>	
	
	<!-- layout the output ports-->
	<xsl:for-each select="MPORT[@DIR='O']">
		<xsl:sort data-type="number" select="@PRTNUMBER" order="ascending"/>
		<xsl:variable name="prt_oy_pos_" select="$prt_ini_y_ + ((position() - 1) * ($MOD_PRT_SPC + $MOD_PRT_H))"/>
		<xsl:if test="@MSB and @LSB">
			<use x="{$prt_ox_pos_}" y="{$prt_oy_pos_}" xlink:href="#MOD_MPort"/> </xsl:if>
		<xsl:if test="not(@MSB) or not(@LSB)">
			<use x="{$prt_ox_pos_}" y="{$prt_oy_pos_}" xlink:href="#MOD_SPort"/>
		</xsl:if>
		<text class="portlabel" 
			x="{$prt_ox_pos_ - 6}" 
			y="{$prt_oy_pos_ + 6}"><xsl:value-of select="@PRTNUMBER"/></text>
	</xsl:for-each>
	
</xsl:template>

<xsl:template name="Draw_BusBifs">
	<xsl:param name="body_width"   select="0"/>
	<xsl:param name="body_height"  select="0"/>
	
	<xsl:param name="gap_bot"      select="$MOD_V_GAP"/>
	<xsl:param name="gap_top"      select="$MOD_V_GAP"/>
	<xsl:param name="gap_rght"     select="$MOD_H_GAP"/>
	<xsl:param name="gap_left"     select="$MOD_H_GAP"/>

	<xsl:variable name="bus_h_">
		<xsl:value-of select="$MOD_BUSARROW_H + $MOD_V_GAP"/>
	</xsl:variable>	
	
	<xsl:variable name="bus_slv_cnt_" select="count(BUSINTERFACE[(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='SLAVE'])"/>	
	<xsl:variable name="bus_mas_cnt_" select="count(BUSINTERFACE[(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='MASTER'])"/>	
		
	<xsl:variable name="cbus_slv_gap_">
		<xsl:choose>
			<xsl:when test="$bus_slv_cnt_ &gt; 0">
				<xsl:value-of select="ceiling($body_width div ($bus_slv_cnt_ + 1))"/>
			</xsl:when>
			<xsl:when test="$bus_slv_cnt_ &lt; 1">0</xsl:when>
		</xsl:choose>
	</xsl:variable>	
	
	<xsl:variable name="cbus_mas_gap_">
		<xsl:if test="$bus_mas_cnt_ &gt; 0">
			<xsl:value-of select="ceiling($body_width div ($bus_mas_cnt_ + 1))"/>
		</xsl:if>
		<xsl:if test="$bus_mas_cnt_ &lt; 1">0</xsl:if>
	</xsl:variable>	

	
	<!-- Layout the Top (SLAVE) Busses-->
	<xsl:variable name="slv_x_pos_">
		<xsl:value-of select="$MOD_H_GAP"/>
	</xsl:variable>	
	
	<xsl:for-each select="BUSINTERFACE[(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='SLAVE']">	
		
		<xsl:variable name="sbusIndex_">
			<xsl:if test="@BUSINDEX">
				<xsl:value-of select="@BUSINDEX"/>	
			</xsl:if>	
			<xsl:if test="not(@BUSINDEX)">
				<xsl:value-of select="position()"/>	
			</xsl:if>	
		</xsl:variable>
		
		<xsl:variable name="slv_y_pos_" select="(($sbusIndex_ - 1) * $bus_h_)"/>
		<xsl:variable name="slv_dom_"   select="@BUSDOMAIN"/>
		
		<xsl:variable name="slv_col_">
			<xsl:choose>
				<xsl:when test="$slv_dom_ = 'OPB'">
					<xsl:value-of select="$MOD_COL_OPB"/>
				</xsl:when>
				<xsl:when test="$slv_dom_ = 'PLB'">
					<xsl:value-of select="$MOD_COL_PLB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$MOD_COL_OPB"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
		
		<xsl:variable name="slv_col_txt_">
			<xsl:choose>
				<xsl:when test="$slv_dom_ = 'OPB'">
					<xsl:value-of select="$MOD_COL_OPB"/>
				</xsl:when>
				<xsl:when test="$slv_dom_ = 'PLB'">
					<xsl:value-of select="$MOD_COL_PLB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$MOD_COL_OPB"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
	
		<use x="{$slv_x_pos_}"
			 y="{$slv_y_pos_}"
		     xlink:href="#MOD_{$slv_dom_}_BusBody"/>
			 
		<text class="iplabel"
				x="{ceiling($body_width div 2) + 50}"
				y="{$slv_y_pos_ + $MOD_BUSARROW_H}">
		      <xsl:value-of select="@BUSNAME"/>
		</text>	
			
		<xsl:variable name="cslv_y_pos_" select="$slv_y_pos_ + $MOD_BUSARROW_H - $MOD_BUSARROW_INDENT"/>
		<xsl:variable name="cslv_x_pos_" select="$slv_x_pos_ + (position() * $cbus_slv_gap_)"/>
		
		<rect x="{$cslv_x_pos_ - ceiling($MOD_CBUSCONNECT_W div 2)}"  
			  y="{$cslv_y_pos_}"    
			  width ="{$MOD_CBUSCONNECT_W}"  
			  height="{$gap_top - $MOD_CBUSARROW_H - $cslv_y_pos_}"
			  style="fill:{$slv_col_}; fill-opacity: 1.0; stroke:none;"/> 
				
		<use x="{$cslv_x_pos_ - ceiling($MOD_CBUSARROW_W div 2)}"
			 y="{$gap_top - $MOD_CBUSARROW_H}"
		     xlink:href="#MOD_{$slv_dom_}_CBusArrowSouth"/>
	 	
		<text style="fill:{$slv_col_};
				stroke:none; 
				font-size:8pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{$cslv_x_pos_}"
				y="{$gap_top + 10}">
		      <xsl:value-of select="@BIFNAME"/>
		</text>	
			
	</xsl:for-each>
	
	<!--  Layout the Bottom (Master) Busses -->
	<xsl:variable name="mas_x_pos_">
		<xsl:value-of select="$MOD_H_GAP"/>
	</xsl:variable>	
	
	<xsl:variable name="mas_iy_pos_">
		<xsl:value-of select="$gap_top + $body_height"/>
	</xsl:variable>	
	
	<xsl:for-each select="BUSINTERFACE[(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='MASTER']">	
			
		<xsl:variable name="mbusIndex_">
			<xsl:if test="@BUSINDEX">
				<xsl:value-of select="@BUSINDEX"/>	
			</xsl:if>	
			<xsl:if test="not(@BUSINDEX)">
				<xsl:value-of select="position()"/>	
			</xsl:if>	
		</xsl:variable>
		
		<xsl:variable name="mas_y_pos_" select="$mas_iy_pos_ + ($mbusIndex_ * $bus_h_)"/>
		<xsl:variable name="mas_dom_"   select="@BUSDOMAIN"/>
		
		<xsl:variable name="mas_col_">
			<xsl:choose>
				<xsl:when test="$mas_dom_ = 'OPB'">
					<xsl:value-of select="$MOD_COL_OPB"/>
				</xsl:when>
				<xsl:when test="$mas_dom_ = 'PLB'">
					<xsl:value-of select="$MOD_COL_PLB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$MOD_COL_OPB"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
		
		<xsl:variable name="mas_col_txt_">
			<xsl:choose>
				<xsl:when test="$mas_dom_ = 'OPB'">
					<xsl:value-of select="$MOD_COL_OPB"/>
				</xsl:when>
				<xsl:when test="$mas_dom_ = 'PLB'">
					<xsl:value-of select="$MOD_COL_PLB"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$MOD_COL_OPB"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
	
		<use x="{$mas_x_pos_}"
			 y="{$mas_y_pos_}"
		     xlink:href="#MOD_{$mas_dom_}_BusBody"/>

		<text class="iplabel"
				x="{ceiling($body_width div 2) + 50}"
				y="{$mas_y_pos_ + $MOD_BUSARROW_H}">
		      <xsl:value-of select="@BUSNAME"/>
		</text>	
		
		<xsl:variable name="cmas_y_pos_" select="$mas_y_pos_ + $MOD_BUSARROW_INDENT - $MOD_CBUSARROW_H"/>
		<xsl:variable name="cmas_x_pos_" select="$mas_x_pos_ + (position() * $cbus_mas_gap_)"/>
		
		<use x="{$cmas_x_pos_ - ceiling($MOD_CBUSARROW_W div 2)}"
			 y="{$cmas_y_pos_}"
		     xlink:href="#MOD_{$mas_dom_}_CBusArrowSouth"/>
		
		<rect x="{$cmas_x_pos_ - ceiling($MOD_CBUSCONNECT_W div 2)}"  
			  y="{$gap_top + $body_height}"    
			  width ="{$MOD_CBUSCONNECT_W}"  
			  height="{$cmas_y_pos_ - ($gap_top + $body_height)}"
			  style="fill:{$mas_col_}; fill-opacity: 1.0; stroke:none;"/> 
				
		<text style="fill:{$mas_col_};
				stroke:none; 
				font-size:8pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{$cmas_x_pos_}"
				y="{$gap_top + $body_height - 2}">
		      <xsl:value-of select="@BIFNAME"/>
		</text>	
	</xsl:for-each>
	
</xsl:template>

<xsl:template name="Draw_P2PBifs">
	<xsl:param name="body_width"   select="0"/>
	<xsl:param name="body_height"  select="0"/>
	
	<xsl:param name="gap_ports"    select="$MOD_V_GAP"/>
	<xsl:param name="gap_bot"      select="$MOD_V_GAP"/>
	<xsl:param name="gap_top"      select="$MOD_V_GAP"/>
	<xsl:param name="gap_rght"     select="$MOD_H_GAP"/>
	<xsl:param name="gap_left"     select="$MOD_H_GAP"/>
	
	<xsl:variable name="bif_x_pos_">
		<xsl:value-of select="$MOD_H_GAP"/>
	</xsl:variable>	
	
	<xsl:variable name="bif_h_">
		<xsl:value-of select="$MOD_BIF_H + $MOD_V_GAP"/>
	</xsl:variable>	
	
	<xsl:variable name="bif_ini_y_">
		<xsl:value-of select="$gap_top + $MOD_V_GAP + $MOD_PRT_SY + $gap_ports"/>
	</xsl:variable>	
		
	<xsl:variable name="bifs_left_cnt_"  select="count(BUSINTERFACE[not(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='SLAVE'])"/>	
	<xsl:variable name="bifs_rght_cnt_"  select="count(BUSINTERFACE[not(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='MASTER'])"/>	
	<xsl:variable name="bifs_acrs_cnt_"  select="count(BUSINTERFACE[@BIFRANK ='TRANSPARENT'])"/>	

	<!-- SLAVE BIFS -->	
	<xsl:for-each  select="BUSINTERFACE[not(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='SLAVE']">	
		<xsl:variable name="slv_y_pos_" select="$bif_ini_y_ + ((position() - 1)  * $bif_h_)"/>
		<xsl:variable name="slv_dom_"   select="@BUSDOMAIN"/>
		
			<use x="{$bif_x_pos_}"  
				 y="{$slv_y_pos_}"  
		         xlink:href="#MOD_{$slv_dom_}_BifBody"/>
				 
			<text style="fill:{$MOD_COL_BLACK};
				stroke:none; 
				font-size:6pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{$MOD_BIF_W  + 32}"
				y="{$slv_y_pos_ + 7}">
		      <xsl:value-of select="@BIFNAME"/>
			</text>	
			
	</xsl:for-each>
	
	<!-- MASTER BIFS -->	
	<xsl:variable name="mas_x_pos_">
		<xsl:value-of select="$MOD_H_GAP + $body_width - $MOD_BIF_W"/>
	</xsl:variable>	
	
	<xsl:for-each  select="BUSINTERFACE[not(@BUSDOMAIN='OPB' or @BUSDOMAIN='PLB') and @BIFRANK='MASTER']">	
		<xsl:variable name="mas_y_pos_" select="$bif_ini_y_ + ((position() - 1)  * $bif_h_)"/>
		<xsl:variable name="mas_dom_"   select="@BUSDOMAIN"/>
		
			<use x="{$mas_x_pos_}"  
				 y="{$mas_y_pos_}"  
		         xlink:href="#MOD_{$mas_dom_}_BifBody"/>
				 
			<text style="fill:{$MOD_COL_BLACK};
				stroke:none; 
				font-size:6pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{$mas_x_pos_ - 20}"
				y="{$mas_y_pos_ + 7}">
		      <xsl:value-of select="@BIFNAME"/>
			</text>	
			
	</xsl:for-each>
	
	
	
	<!-- TRANSPARENT BIFS -->	
    <!-- select and return the maximum between the two left and right of bifs. Start Transparent from there -->
	<xsl:variable name="lr_h_">
		<xsl:choose>
	
			<xsl:when test="($bifs_left_cnt_ &gt; $bifs_rght_cnt_)">
				<xsl:value-of select="(($MOD_BIF_H + $MOD_PRT_SPC) * $bifs_left_cnt_)"/>
			</xsl:when>
		
			<xsl:when test="($bifs_rght_cnt_ &gt; $bifs_left_cnt_)">
				<xsl:value-of select="(($MOD_BIF_H + $MOD_PRT_SPC) * $bifs_rght_cnt_)"/>
			</xsl:when>
			<xsl:otherwise>0</xsl:otherwise>
		</xsl:choose>	
	</xsl:variable>
	
	<xsl:variable name="trs_ini_y_">
		<xsl:value-of select="$bif_ini_y_ + $lr_h_"/>
	</xsl:variable>	
		
	<xsl:for-each select="BUSINTERFACE[@BIFRANK ='TRANSPARENT']">	
		<xsl:variable name="trs_y_pos_" select="$trs_ini_y_ + ((position() - 1)  * $bif_h_)"/>
		
		<xsl:variable name="bifn_len_" select="string-length(@BIFNAME)"/>
		
			<use x="{$bif_x_pos_}"  
				 y="{$trs_y_pos_}"  
		         xlink:href="#MOD_TRS_BifBody"/>
		
			<use x="{$bif_x_pos_ + $body_width - $MOD_BIF_W }"  
				 y="{$trs_y_pos_}"  
		         xlink:href="#MOD_TRS_BifBody"/>
				 
			<text style="fill:{$MOD_COL_BLACK};
				stroke:none; 
				font-size:6pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{$MOD_BIF_W  + $MOD_H_GAP + ($bifn_len_ * 3)}"
				y="{$trs_y_pos_ + 7}">
		      <xsl:value-of select="@BIFNAME"/>
			</text>	
			
			<text style="fill:{$MOD_COL_BLACK};
				stroke:none; 
				font-size:6pt;
				font-style:normal;
				fill-opacity:1.0;
				font-weight:900; 
				text-anchor:middle;
				font-family:Arial,Helvetica,sans-serif"
				x="{$bif_x_pos_  + $body_width - $MOD_BIF_W - ($bifn_len_ * 3)}"
				y="{$trs_y_pos_ + 7}">
		      <xsl:value-of select="@BIFNAME"/>
			</text>	
			
	</xsl:for-each>
	
</xsl:template>

<xsl:template name="Draw_Module">
	
	<xsl:param name="body_width"   select="0"/>
	<xsl:param name="body_height"  select="0"/>
	
	<xsl:param name="gap_ports"    select="$MOD_V_GAP"/>
	<xsl:param name="gap_bot"      select="$MOD_V_GAP"/>
	<xsl:param name="gap_top"      select="$MOD_V_GAP"/>
	<xsl:param name="gap_rght"     select="$MOD_H_GAP"/>
	<xsl:param name="gap_left"     select="$MOD_H_GAP"/>

	<use x="{$MOD_H_GAP}"  
		 y="{$gap_top}"  
		 xlink:href="#MOD_StandardBody"/>
		 
	<xsl:variable name="inner_w_" select="$body_width - ($gap_left + $gap_rght)"/>
	
	<text class="iptype" 
		  x="{$MOD_H_GAP + $gap_left + ceiling($inner_w_ div 2)}" 
		  y="{$gap_top   + ceiling($body_height div 2) + 4}">
		<xsl:value-of select="@MODTYPE"/>
	</text>
	
	<text class="iplabel" 
		  x="{$MOD_H_GAP + $gap_left + ceiling($inner_w_ div 2)}" 
		  y="{$gap_top   + ceiling($body_height div 2) + 16}">
		<xsl:value-of select="@INSTANCE"/>
	</text>

	<xsl:call-template name="Draw_Ports">
		<xsl:with-param name="body_width"   select="$body_width"/>
		<xsl:with-param name="body_height"  select="$body_height"/>
		<xsl:with-param name="gap_bot"      select="$gap_bot"/>
		<xsl:with-param name="gap_top"      select="$gap_top"/>
		<xsl:with-param name="gap_rght"     select="$gap_rght"/>
		<xsl:with-param name="gap_left"     select="$gap_left"/>
	</xsl:call-template>		
	
	<xsl:call-template name="Draw_BusBifs">
		<xsl:with-param name="body_width"   select="$body_width"/>
		<xsl:with-param name="body_height"  select="$body_height"/>
		<xsl:with-param name="gap_bot"      select="$gap_bot"/>
		<xsl:with-param name="gap_top"      select="$gap_top"/>
	</xsl:call-template>		
	
	<xsl:call-template name="Draw_P2PBifs">
		<xsl:with-param name="body_width"   select="$body_width"/>
		<xsl:with-param name="body_height"  select="$body_height"/>
		
		<xsl:with-param name="gap_ports"    select="$gap_ports"/>
		<xsl:with-param name="gap_bot"      select="$gap_bot"/>
		<xsl:with-param name="gap_top"      select="$gap_top"/>
		<xsl:with-param name="gap_rght"     select="$gap_rght"/>
		<xsl:with-param name="gap_left"     select="$gap_left"/>
	</xsl:call-template>		
	
</xsl:template>


</xsl:stylesheet>

