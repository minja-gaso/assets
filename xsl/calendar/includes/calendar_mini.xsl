<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Called only once for root -->
	<!-- Uses recursion with index + 7 for each week -->
	<xsl:template name="mini_cal_month">
    <xsl:param name="index" select="1"/>
    <xsl:if test="$index &lt; $nelements">
        <xsl:call-template name="mini_cal_week">
            <xsl:with-param name="index" select="$index"/>
        </xsl:call-template>
        <xsl:call-template name="mini_cal_month">
            <xsl:with-param name="index" select="$index + 7"/>
        </xsl:call-template>
    </xsl:if>
	</xsl:template>
	<!-- Called repeatedly by month for each week -->
	<xsl:template name="mini_cal_week">
	    <xsl:param name="index" select="1"/>
	    <tr>
	        <xsl:call-template name="mini_cal_days">
	            <xsl:with-param name="index" select="$index"/>
	            <xsl:with-param name="counter" select="$index + 6"/>
	        </xsl:call-template>
	    </tr>
	</xsl:template>
	<!-- Called by week -->
	<!-- Uses recursion with index + 1 for each day-of-week -->
	<xsl:template name="mini_cal_days">
	    <xsl:param name="index" select="1"/>
	    <xsl:param name="counter" select="1"/>
	    <xsl:choose>
	        <xsl:when test="$index &lt; $start">
	            <td>-</td>
	        </xsl:when>
	        <xsl:when test="$index - $start + 1 > $count">
	            <td>-</td>
	        </xsl:when>
	        <xsl:when test="$index > $start - 1">
	            <td><xsl:value-of select="$index - $start + 1"/></td>
	        </xsl:when>
	    </xsl:choose>
	    <xsl:if test="$counter > $index">
	        <xsl:call-template name="mini_cal_days">
	            <xsl:with-param name="index" select="$index + 1"/>
	            <xsl:with-param name="counter" select="$counter"/>
	        </xsl:call-template>
	    </xsl:if>
	</xsl:template>
  <xsl:template name="display_mini_calendar">
    <table summary="mini calendar" id="mini-cal" border="1" bgcolor="yellow" align="center">
			<thead>
				<tr>
					<th>Sun</th>
					<th>Mon</th>
					<th>Tue</th>
					<th>Wed</th>
					<th>Thu</th>
					<th>Fri</th>
					<th>Sat</th>
				</tr>
			</thead>
			<tbody>
				<xsl:call-template name="mini_cal_month"/>
			</tbody>
		</table>
  </xsl:template>
</xsl:stylesheet>
