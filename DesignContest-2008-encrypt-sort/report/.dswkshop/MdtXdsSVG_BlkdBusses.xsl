<?xml version="1.0" standalone="no"?> <xsl:stylesheet version="1.0"
           xmlns:svg="http://www.w3.org/2000/svg"
           xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
           xmlns:exsl="http://exslt.org/common"
           xmlns:xlink="http://www.w3.org/1999/xlink">
                
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
	       doctype-public="-//W3C//DTD SVG 1.0//EN"
		   doctype-system="http://www.w3.org/TR/SVG/DTD/svg10.dtd"/>
		

<xsl:param name="BUS_ARROW_W"  select="32"/>	
<xsl:param name="BUS_ARROW_H"  select="32"/>				

<xsl:param name="BUS_W"        select="800"/>
<xsl:param name="BRIDGE_H"     select="64"/>

<xsl:param name="BUS_GAP_Y"    select="20"/>
<xsl:param name="IP_ARROW_H"  select="8"/>
<xsl:param name="BRIDGE_ARROW_W"   select="8"/>
<xsl:param name="BRIDGE_ARROW_H"   select="8"/>
<xsl:param name="BRIDGE_VCONNE_L"  select="10"/>
	
<xsl:param name="BUS_LMB_ARROW_GAP"  select="6"/>
<xsl:param name="BUS_LMB_ARROW_H"    select="24"/>
<xsl:param name="BUS_LMB_ARROW_W"    select="24"/>
<xsl:param name="BUS_LMB_CONNE_H"    select="32"/>
<xsl:param name="BUS_LMB_HCONNE_L"   select="32"/>
<xsl:param name="BUS_LMB_VCONNE_L"   select="50"/>

<xsl:param name="BUS_FSL_ARROW_GAP"  select="6"/>
<xsl:param name="BUS_FSL_ARROW_H"    select="24"/>
<xsl:param name="BUS_FSL_ARROW_W"    select="24"/>
<xsl:param name="BUS_FSL_CONNE_H"    select="32"/>
<xsl:param name="BUS_FSL_HCONNE_L"   select="96"/>

<!--
<xsl:param name="BUS_COL_OPB"      select="'#339900'"/>				
<xsl:param name="BUS_COL_PLB"      select="'#FF3300'"/>				
<xsl:param name="BUS_COL_LMB"      select="'#9999FF'"/>				
-->

<xsl:variable name="BRIDGE_CONNE_H"  select="($BRIDGE_ARROW_H * 2) + $BRIDGE_VCONNE_L"/> 
<xsl:variable name="BUS_BRIDGE_H"    select="($BRIDGE_CONNE_H * 2) + $IP_H"/> 
	        
<xsl:template name="Layout_BusDefs">
	<xsl:param name="bus_width_"      select="800"/>				
	
<!-- ======================= LMB BUS =============================== -->
	<xsl:call-template name="Layout_ArrowEastDef"> 
		<xsl:with-param name="bus_col"     select="$BLKD_COL_LMBBUS"/>
		<xsl:with-param name="bus_type"    select="'LMB'"/>
		<xsl:with-param name="bus_arrow_w" select="$BUS_LMB_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$BUS_LMB_ARROW_H"/>
	</xsl:call-template>
	
	<xsl:call-template name="Layout_ArrowNorthDef"> 
		<xsl:with-param name="bus_col"     select="$BLKD_COL_LMBBUS"/>
		<xsl:with-param name="bus_type"    select="'LMB'"/>
		<xsl:with-param name="bus_arrow_w" select="$BUS_LMB_ARROW_W"/>
		<xsl:with-param name="bus_arrow_h" select="$BUS_LMB_ARROW_H"/>
	</xsl:call-template>
	
	<symbol id="LMB_BusShape">
		<rect  x="{$BUS_LMB_ARROW_GAP}" 
			   y="{$BUS_LMB_ARROW_GAP}"
			   width= "{$BUS_LMB_HCONNE_L}" 
			   height="{$BUS_LMB_ARROW_H - ($BUS_LMB_ARROW_GAP * 2)}" 
			   style="fill:{$BLKD_COL_LMBBUS};"/>
			   
		<use   x="{$BUS_LMB_HCONNE_L}"  y="0"  xlink:href="#LMB_ArrowEast"/>	
		
		<rect  x="{$BUS_LMB_ARROW_GAP}" 
			   y="{$BUS_LMB_ARROW_GAP}" 
			   height="{$BUS_LMB_VCONNE_L}" 
			   width="{$BUS_LMB_ARROW_H - ($BUS_LMB_ARROW_GAP * 2)}" 
			   style="fill:{$BLKD_COL_LMBBUS};"/>
		<use   y="{$BUS_LMB_VCONNE_L}"  x="0"  xlink:href="#LMB_ArrowNorth"/>	
	</symbol>
	
<!--	
	<symbol id="LMB_BusShapeI">
		<use   y="0"  x="0"  xlink:href="#LMB_BusShape"/>
	</symbol>
-->	
	
	<symbol id="LMB_BusShapeI">
		<use   y="0"  x="0"  xlink:href="#LMB_BusShape" transform="scale(1,-1) translate(0,{(($BUS_LMB_VCONNE_L + $BUS_LMB_ARROW_H) * -1)})"/>	
		
		<text style="fill:{$BLKD_COL_LMBBUS_TXT};
			stroke:none; 
			font-size:9pt;
			font-style:normal;
			fill-opacity:1.0;
			font-weight:bold; 
			text-anchor:middle;
			font-family:Verdana,Arial,Courier,sans-serif"
			x="{ceiling($BUS_LMB_HCONNE_L div 2) + $BUS_LMB_ARROW_GAP}" 
			y="{$BUS_LMB_ARROW_W + $BUS_LMB_VCONNE_L - 8}">LMB</text>	
	</symbol>
	
	<symbol id="LMB_BusShapeD">
		<use   y="0"  x="0"  xlink:href="#LMB_BusShape" transform="scale(-1,-1) translate({($BUS_LMB_HCONNE_L + $BUS_LMB_ARROW_H) * -1},{(($BUS_LMB_VCONNE_L + $BUS_LMB_ARROW_H) * -1)})"/>	
		<text style="fill:{$BLKD_COL_LMBBUS_TXT};
			stroke:none; 
			font-size:9pt;
			font-style:normal;
			fill-opacity:1.0;
			font-weight:bold; 
			text-anchor:middle;
			font-family:Verdana,Arial,Courier,sans-serif"
			x="{ceiling($BUS_LMB_HCONNE_L div 2) + $BUS_LMB_ARROW_W - 4}" 
			y="{$BUS_LMB_ARROW_W + $BUS_LMB_VCONNE_L - 8}">LMB</text>	
	</symbol>
	
<!-- ======================= OPB BUS =============================== -->
	 <symbol id="OPB_ArrowEast">
		<path class="bus"
			  d="M   0    0, 
				 L       {$BUS_ARROW_W}, {ceiling($BUS_ARROW_H div 2)} 
				 L   0,  {$BUS_ARROW_W}, 
				 Z" style="stroke:none; fill:{$BLKD_COL_OPBBUS}"/>
	</symbol>
	
	 <symbol id="OPB_BusArrowWest">
		<use   x="0"   y="0"  xlink:href="#OPB_ArrowEast" transform="scale(-1,1) translate({$BUS_ARROW_W * -1},0)"/>
	</symbol>
	
	 <symbol id="OPB_BusShape">
		<use  x="0"  y="0"   xlink:href="#OPB_BusArrowWest"/>	
		<use  x="{$bus_width_ - $BUS_ARROW_W}" y="0"   xlink:href="#OPB_ArrowEast"/>	
		<rect x="{$BUS_ARROW_W}" 
			  y="8"  
			  width= "{$bus_width_ - ($BUS_ARROW_W * 2)}" 
			  height="{$BUS_ARROW_H - (2 * 8)}" style="stroke:none; fill:{$BLKD_COL_OPBBUS}"/>
	</symbol>	
	
	<xsl:call-template name="Layout_BridgeArrowDefs">
		<xsl:with-param name="bus_col"       select="$BLKD_COL_OPBBUS"/>
		<xsl:with-param name="bus_type"      select="'OPB'"/>
	</xsl:call-template>
	
<!-- ======================= PLB BUS =============================== -->
	 <symbol id="PLB_BusArrowEast">
		<path class="bus"
			  d="M   0    0, 
				 L       {$BUS_ARROW_W}, {ceiling($BUS_ARROW_H div 2)} 
				 L   0,  {$BUS_ARROW_W}, 
				 Z" style="stroke:none; fill:{$BLKD_COL_PLBBUS}"/>
	</symbol>
	
	 <symbol id="PLB_BusArrowWest">
		<use   x="0"   y="0"  xlink:href="#PLB_BusArrowEast" transform="scale(-1,1) translate({$BUS_ARROW_W * -1},0)"/>
	</symbol>
	
	 <symbol id="PLB_BusShape">
		<use  x="0"  y="0"   xlink:href="#PLB_BusArrowWest"/>	
		<use  x="{$bus_width_ - $BUS_ARROW_W}" y="0"   xlink:href="#PLB_BusArrowEast"/>	
		<rect x="{$BUS_ARROW_W}" 
			  y="8"  
			  width= "{$bus_width_ - ($BUS_ARROW_W * 2)}" 
			  height="{$BUS_ARROW_H - (2 * 8)}" style="stroke:none; fill:{$BLKD_COL_PLBBUS}"/>
	</symbol>	
	
	<xsl:call-template name="Layout_BridgeArrowDefs">
		<xsl:with-param name="bus_col"       select="$BLKD_COL_PLBBUS"/>
		<xsl:with-param name="bus_type"      select="'PLB'"/>
	</xsl:call-template>
	
<!-- ======================= FSL BUS =============================== -->
	 <symbol id="FSL_BusArrowEast">
		<path class="bus"
			  d="M   0    0, 
				 L       {$BUS_FSL_ARROW_W}, {ceiling($BUS_FSL_ARROW_H div 2)} 
				 L   0,  {$BUS_FSL_ARROW_W}, 
				 Z" style="stroke:none; fill:{$BLKD_COL_FSLBUS}"/>
	</symbol>
	
<!--	
	 <symbol id="FSL_BusArrowWest">
		<use   x="0"   y="0"  xlink:href="#FSL_BusArrowEast" transform="scale(-1,1) translate({$BUS_ARROW_W * -1},0)"/>
	</symbol>
-->	
	
	 <symbol id="FSL_BusMaster">
		<rect x="0" 
			  y="{$BUS_FSL_ARROW_GAP}"  
			  width= "{$BUS_FSL_HCONNE_L}" 
			  height="{$BUS_FSL_ARROW_H - (2 * $BUS_FSL_ARROW_GAP)}" style="stroke:none; fill:{$BLKD_COL_FSLBUS}"/>
		<use  x="{$BUS_FSL_HCONNE_L}" 
			  y="0"   xlink:href="#FSL_BusArrowEast"/>	
	</symbol>	
	
	 <symbol id="FSL_BusSlave">
		<use  x="0" y="0"   
			  xlink:href="#FSL_BusMaster" transform="scale(-1,1) translate({($BUS_FSL_ARROW_W + $BUS_FSL_HCONNE_L) * -1},0)"/>
	 </symbol>	
	
</xsl:template>


<!-- ======================= GENERAL LAYOUT =========================== -->
<xsl:template name="Draw_Busses"> 
	
	<xsl:param name="bus_width"  select="800"/>
	<xsl:param name="x_pos"      select="100"/>
	<xsl:param name="y_pos"      select="100"/>	
	
	
	<xsl:for-each select="RENDERINFO/BUSSHAPE">
		<xsl:sort data-type="number" select="@BUSINDEX" order="ascending"/>
		
		<xsl:variable name="ins_name_"    select="@INSTANCE"/>	
		<xsl:variable name="mod_type_"    select="@MODTYPE"/>	
		<xsl:variable name="bus_type_"    select="@BUSTYPE"/>	
		
		<xsl:variable name="bus_y_pos_"   select="$y_pos + ((position() -1) * ($BUS_BRIDGE_H + $BUS_ARROW_H))"/>
		
		<xsl:variable name="bus_col_">
			
			<xsl:if test="$bus_type_ = 'OPB'">
				<xsl:value-of select="$BLKD_COL_OPBBUS"/>
			</xsl:if>
			
			<xsl:if test="$bus_type_ = 'PLB'">
				<xsl:value-of select="$BLKD_COL_PLBBUS"/>
			</xsl:if>
			
		</xsl:variable>
			
		<xsl:variable name="bus_col_TXT_">
			
			<xsl:if test="$bus_type_ = 'OPB'">
				<xsl:value-of select="$BLKD_COL_OPBBUS_TXT"/>
			</xsl:if>
			
			<xsl:if test="$bus_type_ = 'PLB'">
				<xsl:value-of select="$BLKD_COL_PLBBUS_TXT"/>
			</xsl:if>
			
		</xsl:variable>
			
		<xsl:if test="$bus_type_ = 'PLB'">
			<use  x="{$x_pos}"  y="{$bus_y_pos_}" xlink:href="#PLB_BusShape"/>	
		</xsl:if>	
			
		<xsl:if test="$bus_type_ = 'OPB'">
			<use  x="{$x_pos}"  y="{$bus_y_pos_}" xlink:href="#OPB_BusShape"/>	
		</xsl:if>	
			
		<text class="iptype"
			x="{($x_pos      + ($BUS_ARROW_W * 2))}" 
			y="{($bus_y_pos_ +                 2)}">
			<xsl:value-of select="$mod_type_"/>
		</text>		
			
		<text class="iplabel"
			x="{($x_pos      + ($BUS_ARROW_W * 2))}" 
			y="{($bus_y_pos_ +  $BUS_ARROW_H + 4)}">
			<xsl:value-of select="$ins_name_"/>
		</text>		
		
		<text class="iptype"
			x="{(($x_pos  + $bus_width)  - ($BUS_ARROW_W * 2))}" 
			y="{($bus_y_pos_ +                 2)}">
			<xsl:value-of select="$mod_type_"/>
		</text>		
			
		<text class="iplabel"
			x="{(($x_pos  +  $bus_width) - ($BUS_ARROW_W * 2))}" 
			y="{($bus_y_pos_ +  $BUS_ARROW_H + 4)}">
			<xsl:value-of select="$ins_name_"/>
		</text>		
		
		<text style="fill:{$bus_col_TXT_};
			stroke:none; 
			font-size:14pt;
			font-style:normal;
			fill-opacity:1.0;
			font-weight:bold; 
			text-anchor:middle;
			font-family:Verdana,Arial,Courier,sans-serif"
			x="{($x_pos      + ceiling($bus_width   div 2))}" 
			y="{($bus_y_pos_ + ceiling($BUS_ARROW_H div 2) + 8)}">
			<xsl:value-of select="$bus_type_"/>
		</text>	
		
	</xsl:for-each>
	
	<xsl:for-each select="RENDERINFO/BRIDGESHAPE">
		<xsl:sort data-type="number" select="@FROMBUS_INDEX" order="ascending"/>
		
		<xsl:variable name="bridge_y_pos_"   select="$y_pos + (@FROMBUS_INDEX * ($BUS_BRIDGE_H + $BUS_ARROW_H))"/>
		<xsl:call-template name="Draw_BusBridge">	
			<xsl:with-param name="x_pos"      select="$x_pos         + ($BUS_ARROW_W * 3)"/>
			<xsl:with-param name="y_pos"      select="$bridge_y_pos_ +  $BUS_ARROW_H"/>
			<xsl:with-param name="ip_name"    select="@INSTANCE"/>
			<xsl:with-param name="ip_type"    select="@MODTYPE"/>
			<xsl:with-param name="from_type"  select="@FROMBUS_TYPE"/>
			<xsl:with-param name="to_type"    select="@TOBUS_TYPE"/>
		</xsl:call-template>
	</xsl:for-each>
	
</xsl:template>
	
	
<!-- ======================= GENERAL LAYOUT =========================== -->

<xsl:template name="Layout_BridgeArrowDefs">
	<xsl:param name="bus_col"          select="$BLKD_COL_OPBBUS"/>
	<xsl:param name="bus_type"         select="'OPB'"/>
	
	 <symbol id="{$bus_type}_BridgeArrowNorth">
		<path class="bus"
			  d="M   {ceiling($BRIDGE_ARROW_W div 2)},0
				 L   {$BRIDGE_ARROW_H}, {$BRIDGE_ARROW_W}
				 L   0,{$BRIDGE_ARROW_H}, 
				 Z" style="stroke:none; fill:{$bus_col}"/>
	</symbol>
	
	<symbol id="{$bus_type}_BridgeArrowSouth">
		<use   x="0"   y="0"  xlink:href="#{$bus_type}_BridgeArrowNorth" transform="scale(1,-1) translate(0,{$BRIDGE_ARROW_H * -1})"/>
	</symbol>
	
	<symbol id="{$bus_type}_BridgeArrow">
		<use   x="0"   y="0"  xlink:href="#{$bus_type}_BridgeArrowNorth"/>
		<line  x1="{ceiling($BRIDGE_ARROW_W div 2) - 1}" 
			   y1="{$BRIDGE_ARROW_H}" 
			   x2="{ceiling($BRIDGE_ARROW_W div 2) -1}" 
			   y2="{$BRIDGE_ARROW_H + $BRIDGE_VCONNE_L}" 
			   style="stroke:{$bus_col};stroke-width:2"/>
		<use   x="0"   y="{$BRIDGE_ARROW_H + $BRIDGE_VCONNE_L}"  xlink:href="#{$bus_type}_BridgeArrowSouth"/>
	</symbol>
	
</xsl:template>

<xsl:template name="Draw_BusBridge">
	
	<xsl:param name="x_pos"         select="0"/>	
	<xsl:param name="y_pos"         select="0"/>	
	<xsl:param name="ip_name"       select="'ip_name'"/>
	<xsl:param name="ip_type"       select="'ip_type'"/>
	<xsl:param name="from_type"     select="'PLB'"/>	
	<xsl:param name="to_type"       select="'OPB'"/>	

	<use   x="{$x_pos + ceiling($IP_W div 2)}"  y="{$y_pos}"  xlink:href="#{$from_type}_BridgeArrow"/>
		
	<xsl:variable name="ip_x_pos_" select="$x_pos"/>
	<xsl:variable name="ip_y_pos_" select="$y_pos + $BRIDGE_CONNE_H"/>
	<xsl:variable name="lc_y_pos_" select="$ip_y_pos_ + $IP_H"/>
	
	<rect  x="{$ip_x_pos_}"  
		   y="{$ip_y_pos_}"
		   rx="3" ry="3" 
		   width ="{$IP_W}" 
		   height="{$IP_H}" style="fill:{$IP_COL_BLKBG}; fill-opacity: 0.8; stroke: rgb(0,0,0); stroke-width:1"/> 
		   
    <image x="{$ip_x_pos_ + ceiling(($IP_W div 2)) -16}" 
		   y="{$ip_y_pos_ + 16}" 
		   width="32" height="32" xlink:href="ICON_Bridge.gif"/> 
    
	<text class="iptype"
		  x="{$ip_x_pos_ + ceiling($IP_W div 2)}" 
		  y="{$ip_y_pos_ + 10}">
			<xsl:value-of select="$ip_type"/>
	</text>
	
	<text class="iplabel"
		  x="{$ip_x_pos_  + ceiling($IP_W div 2)}" 
		  y="{($ip_y_pos_ + $IP_H) - 6}">
			<xsl:value-of select="$ip_name"/>
	</text>
	
	<use   x="{$x_pos + ceiling($IP_W div 2)}"  y="{$lc_y_pos_}"  xlink:href="#{$to_type}_BridgeArrow"/>
	
</xsl:template>

<xsl:template name="Layout_ArrowEastDef"> 
	<xsl:param name="bus_col"     select="'OPB'"/>
	<xsl:param name="bus_type"    select="'OPB'"/>
	<xsl:param name="bus_arrow_w" select="20"/>
	<xsl:param name="bus_arrow_h" select="20"/>
	
	<symbol id="{$bus_type}_ArrowEast">
		<path class="bus"
			  d="M   0,0
				 L   {$bus_arrow_w}, {ceiling($bus_arrow_h div 2)}
				 L   0,{$bus_arrow_h}, 
				 Z" style="stroke:none; fill:{$bus_col}"/>
	</symbol>
</xsl:template>

<xsl:template name="Layout_ArrowNorthDef"> 
	<xsl:param name="bus_col"     select="'OPB'"/>
	<xsl:param name="bus_type"    select="'OPB'"/>
	<xsl:param name="bus_arrow_w" select="20"/>
	<xsl:param name="bus_arrow_h" select="20"/>
	
	<symbol id="{$bus_type}_ArrowNorth">
		<path class="bus"
			  d="M   0,0
				 L   {$bus_arrow_w},0
				 L   {ceiling($bus_arrow_w div 2)}, {$bus_arrow_h}
				 Z" style="stroke:none; fill:{$bus_col}"/>
	</symbol>
</xsl:template>

<xsl:template name="Calc_Busses_H">
	
	<xsl:param name="bus_cnt"    select="1"/>	
	<xsl:param name="bridge_cnt" select="0"/>
	
	<xsl:variable name="total_bus_height_">
		<xsl:value-of select="($BUS_ARROW_H * $bus_cnt)"/>
	</xsl:variable>
		
	<xsl:variable name="total_gap_height_">
		<xsl:if test="($bus_cnt &gt; 1)">
			<xsl:value-of select="($BUS_BRIDGE_H * ($bus_cnt - 1))"/>
		</xsl:if>
		
		<xsl:if test="not($bus_cnt &gt; 1)">0</xsl:if>
	</xsl:variable>
	
	<xsl:value-of select="$total_bus_height_ +  $total_gap_height_"/>
	
</xsl:template>

<xsl:template name="Test_Busses_H">
	
	<xsl:param name="bus_cnt"    select="1"/>	
	<xsl:param name="bridge_cnt" select="0"/>
	
	<xsl:variable name="total_bus_height_">
		<xsl:value-of select="($BUS_ARROW_H * $bus_cnt)"/>
	</xsl:variable>
	
	<xsl:variable name="total_bridge_height_">
		<xsl:value-of select="($BUS_BRIDGE_H * $bridge_cnt)"/>
	</xsl:variable>
	
	<xsl:variable name="gap_cnt_" select="(($bus_cnt - 1) - $bridge_cnt)"/>
	
	<xsl:variable name="total_gap_height_">
		
		<xsl:if test="gap_cnt_ &gt; 0">
			<xsl:value-of select="($BUS_BRIDGE_H * $gap_cnt)"/>
		</xsl:if>
		
		<xsl:if test="not(gap_cnt_ &gt; 0)">0</xsl:if>
		
	</xsl:variable>
	
	
	<BCNT><xsl:value-of select="$bus_cnt"/></BCNT>
	<BUSH><xsl:value-of select="$total_bus_height_"/></BUSH>
	<BRDG><xsl:value-of select="$total_bridge_height_"/></BRDG>
	
</xsl:template>


</xsl:stylesheet>
