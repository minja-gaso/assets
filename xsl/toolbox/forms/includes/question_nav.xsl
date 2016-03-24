<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="standard_nav">
    <ul class="nav nav-tabs">
      <xsl:choose>
        <xsl:when test="/data/form/question/type = 'text'">
          <li role="presentation" class="active"><a href="#">Text</a></li>
          <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_TEXTAREA');submitForm();">Textarea</a></li>
        </xsl:when>
        <xsl:when test="/data/form/question/type = 'textarea'">
          <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_TEXT');submitForm();">Text</a></li>
          <li role="presentation" class="active"><a href="#">Textarea</a></li>
        </xsl:when>
      </xsl:choose>
      <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_RADIO');submitForm();">Radio</a></li>
      <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_CHECKBOX');submitForm();">Checkbox</a></li>
      <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_PULLDOWN');submitForm();">Pulldown</a></li>
    </ul>
  </xsl:template>

  <xsl:template name="multiple_choice_nav">
    <ul class="nav nav-tabs">
      <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_TEXT');submitForm();">Text</a></li>
      <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_TEXTAREA');submitForm();">Textarea</a></li>
      <xsl:choose>
        <xsl:when test="/data/form/question/type = 'radio'">
          <li role="presentation" class="active"><a href="#">Radio</a></li>
          <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_CHECKBOX');submitForm();">Checkbox</a></li>
          <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_PULLDOWN');submitForm();">Pulldown</a></li>
        </xsl:when>
        <xsl:when test="/data/form/question/type = 'checkbox'">
          <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_RADIO');submitForm();">Radio</a></li>
          <li role="presentation" class="active"><a href="#">Checkbox</a></li>
          <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_PULLDOWN');submitForm();">Pulldown</a></li>
        </xsl:when>
        <xsl:when test="/data/form/question/type = 'pulldown'">
          <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_RADIO');submitForm();">Radio</a></li>
          <li role="presentation"><a href="javascript:switchTab('QUESTION_TYPE_CHECKBOX');submitForm();">Checkbox</a></li>
          <li role="presentation" class="active"><a href="#">Pulldown</a></li>
        </xsl:when>
      </xsl:choose>
    </ul>
  </xsl:template>
</xsl:stylesheet>
