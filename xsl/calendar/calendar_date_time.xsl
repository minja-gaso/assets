<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="format_time">
    <xsl:param name="startTime" />
    <xsl:param name="endTime" />

    <xsl:variable name="startHourStr" select="substring(startTime, 1, 2)" />
    <xsl:variable name="startHour">
      <xsl:choose>
        <xsl:when test="number($startHourStr) = 0">12</xsl:when>
        <xsl:when test="number($startHourStr) &gt; 12">
          <xsl:value-of select="number($startHourStr) - 12" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="number($startHourStr)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="startMinuteStr" select="substring(startTime, 4, 2)" />
    <xsl:variable name="startMinute" select="number($startMinuteStr)" />
    <xsl:variable name="startMeridiam">
      <xsl:choose>
        <xsl:when test="number($startHourStr) &gt; 11">p.m.</xsl:when>
        <xsl:otherwise>a.m.</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="endHourStr" select="substring(endTime, 1, 2)" />
    <xsl:variable name="endHour">
      <xsl:choose>
        <xsl:when test="number($endHourStr) = 0">12</xsl:when>
        <xsl:when test="number($endHourStr) &gt; 12">
          <xsl:value-of select="number($endHourStr) - 12" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="number($endHourStr)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="endMinuteStr" select="substring(endTime, 4, 2)" />
    <xsl:variable name="endMinute" select="number($endMinuteStr)" />
    <xsl:variable name="endMeridiam">
      <xsl:choose>
        <xsl:when test="number($endHourStr) &gt; 11">p.m.</xsl:when>
        <xsl:otherwise>a.m.</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="startTimeLabel">
      <xsl:value-of select="$startHour" />
      <xsl:if test="$startMinute &gt; 0">
        <xsl:text>:</xsl:text>
        <xsl:value-of select="$startMinute" />
      </xsl:if>
      <xsl:if test="$startMeridiam != $endMeridiam">
        <xsl:value-of select="concat(' ', $startMeridiam)" />
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="endTimeLabel">
      <xsl:value-of select="$endHour" />
      <xsl:if test="$endMinute &gt; 0">
        <xsl:text>:</xsl:text>
        <xsl:value-of select="$endMinute" />
      </xsl:if>
      <xsl:value-of select="concat(' ', $endMeridiam)" />
    </xsl:variable>

    <xsl:value-of select="$startTimeLabel" /> - <xsl:value-of select="$endTimeLabel" />
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
