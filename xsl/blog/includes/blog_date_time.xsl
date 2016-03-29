<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="format_time">
    <xsl:param name="publishTime" />

    <xsl:variable name="publishHourStr" select="substring(publishTime, 1, 2)" />
    <xsl:variable name="publishHour">
      <xsl:choose>
        <xsl:when test="number($publishHourStr) = 0">12</xsl:when>
        <xsl:when test="number($publishHourStr) &gt; 12">
          <xsl:value-of select="number($publishHourStr) - 12" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="number($publishHourStr)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="publishMinuteStr" select="substring(publishTime, 4, 2)" />
    <xsl:variable name="publishMinute" select="number($publishMinuteStr)" />
    <xsl:variable name="publishMeridiam">
      <xsl:choose>
        <xsl:when test="number($publishHourStr) &gt; 11">p.m.</xsl:when>
        <xsl:otherwise>a.m.</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="publishTimeLabel">
      <xsl:value-of select="$publishHour" />
      <xsl:if test="$publishMinute &gt; 0">
        <xsl:text>:</xsl:text>
        <xsl:value-of select="$publishMinute" />
      </xsl:if>
    </xsl:variable>

    <xsl:value-of select="concat($publishTimeLabel, ' ', $publishMeridiam)" />
  </xsl:template>

  <xsl:template name="format_date">
		<xsl:param name="paramDate" />

		<xsl:variable name="year" select="substring($paramDate, 1, 4)" />
		<xsl:variable name="month" select="substring($paramDate, 6, 2)" />
		<xsl:variable name="monthStr">
			<xsl:choose>
				<xsl:when test="$month = '01'">January</xsl:when>
				<xsl:when test="$month = '02'">February</xsl:when>
				<xsl:when test="$month = '03'">March</xsl:when>
				<xsl:when test="$month = '04'">April</xsl:when>
				<xsl:when test="$month = '05'">May</xsl:when>
				<xsl:when test="$month = '06'">June</xsl:when>
				<xsl:when test="$month = '07'">July</xsl:when>
				<xsl:when test="$month = '08'">August</xsl:when>
				<xsl:when test="$month = '09'">September</xsl:when>
				<xsl:when test="$month = '10'">October</xsl:when>
				<xsl:when test="$month = '11'">November</xsl:when>
				<xsl:when test="$month = '12'">December</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="day" select="substring($paramDate, 9, 2)" />
		<xsl:variable name="dayStr">
			<xsl:choose>
				<xsl:when test="substring($day, 1, 1) = '0'">
					<xsl:value-of select="substring($day, 2, 1)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$day" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="formatted_date" select="concat($monthStr, ' ', $dayStr, ', ', $year)" />

		<xsl:value-of select="$formatted_date" />
	</xsl:template>
</xsl:stylesheet>
