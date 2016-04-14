<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="apos">'</xsl:variable>
  <xsl:variable name="screenName" select="/data/environment/screenName" />
  <xsl:variable name="categoryId" select="/data/calendar/search/categoryId" />
  <xsl:variable name="tagId" select="/data/calendar/search/tagId" />

  <!-- global variables for mini calendar -->
  <xsl:variable name="start" select="/data/calendar/currentView/startDay"/>
  <xsl:variable name="count" select="/data/calendar/currentView/totalDays"/>
  <xsl:variable name="total" select="$start + $count - 1"/>
  <xsl:variable name="overflow" select="$total mod 7"/>
  <xsl:variable name="nelements">
    <xsl:choose>
        <xsl:when test="$overflow > 0"><xsl:value-of select="$total + 7 - $overflow"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$total"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <!-- global variables for mini calendar -->

  <xsl:template name="header">
    <header>
      <h1><xsl:value-of select="/data/form/title" /></h1>
    </header>
  </xsl:template>

  <xsl:template name="intro_message">
		<xsl:if test="string-length(/data/form/messagePublicFormIntro) &gt; 0">
			<div id="app-intro" class="message">
				<xsl:value-of select="/data/form/messagePublicFormIntro" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>

  <xsl:template name="app_message">
    <xsl:if test="count(/data/message[type='error']) &gt; 0">
			<div class="alert alert-danger" role="alert">
				<h2 class="error-heading">Please correct these errors before proceeding:</h2>
				<ul>
					<xsl:for-each select="/data/message[type='error']">
						<xsl:sort select="questionNumber" data-type="number" order="ascending" />
						<li>
							<xsl:value-of select="label" />
						</li>
					</xsl:for-each>
				</ul>
			</div>
		</xsl:if>
  </xsl:template>

	<xsl:template name="footer">
		<footer id="app-footer">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
	</xsl:template>

	<xsl:template name="closing_message">
		<xsl:if test="string-length(/data/form/messagePublicFormClosing) &gt; 0">
			<div id="app-closing" class="message">
				<xsl:value-of select="/data/form/messagePublicFormClosing" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>

  <xsl:template name="external_files">
    <!--
    <link href="/css/resources/bootstrap/styles/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" />
    <link href='https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300' rel='stylesheet' type='text/css' />
    <link href='https://fonts.googleapis.com/css?family=Source+Serif+Pro' rel='stylesheet' type='text/css' />
    <link href="/css/public/blog.css" rel="stylesheet"/>
    <link href="/css/public/share.css" rel="stylesheet"/>
    <link href="/css/public/breadcrumb.css" rel="stylesheet"/>
  -->
    <link href='https://fonts.googleapis.com/css?family=Libre+Baskerville' rel='stylesheet' type='text/css'/>
    <link href="/css/public.css" rel="stylesheet"/>
  </xsl:template>
</xsl:stylesheet>
