<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="standard_nav">
    <xsl:choose>
      <xsl:when test="/data/form/question/type = 'text'">
        <li role="presentation" class="active"><a href="#">Text</a></li>
        <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_TEXTAREA');">Textarea</a></li>
      </xsl:when>
      <xsl:when test="/data/form/question/type = 'textarea'">
        <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_TEXT');">Text</a></li>
        <li role="presentation" class="active"><a href="#">Textarea</a></li>
      </xsl:when>
    </xsl:choose>
    <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_RADIO');">Radio</a></li>
    <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_CHECKBOX');">Checkbox</a></li>
    <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_PULLDOWN');">Pulldown</a></li>
  </xsl:template>

  <xsl:template name="multiple_choice_nav">
    <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_TEXT');">Text</a></li>
    <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_TEXTAREA');">Textarea</a></li>
    <xsl:choose>
      <xsl:when test="/data/form/question/type = 'radio'">
        <li role="presentation" class="active"><a href="#">Radio</a></li>
        <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_CHECKBOX');">Checkbox</a></li>
        <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_PULLDOWN');">Pulldown</a></li>
      </xsl:when>
      <xsl:when test="/data/form/question/type = 'checkbox'">
        <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_RADIO');">Radio</a></li>
        <li role="presentation" class="active"><a href="#">Checkbox</a></li>
        <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_PULLDOWN');">Pulldown</a></li>
      </xsl:when>
      <xsl:when test="/data/form/question/type = 'pulldown'">
        <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_RADIO');">Radio</a></li>
        <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_CHECKBOX');">Checkbox</a></li>
        <li role="presentation" class="active"><a href="#">Pulldown</a></li>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
