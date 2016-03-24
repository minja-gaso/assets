<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="screen">
		<xsl:choose>
			<xsl:when test="/data/form/question/type = 'text'">QUESTION_TYPE_TEXT</xsl:when>
			<xsl:when test="/data/form/question/type = 'textarea'">QUESTION_TYPE_TEXTAREA</xsl:when>
      <xsl:when test="/data/form/question/type = 'radio'">QUESTION_TYPE_RADIO</xsl:when>
      <xsl:when test="/data/form/question/type = 'checkbox'">QUESTION_TYPE_CHECKBOX</xsl:when>
      <xsl:when test="/data/form/question/type = 'pulldown'">QUESTION_TYPE_PULLDOWN</xsl:when>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="questionType" select="/data/form/question/type" />
</xsl:stylesheet>
