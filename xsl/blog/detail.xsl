<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />

	<xsl:import href="includes/blog_global.xsl" />
	<xsl:import href="includes/blog_date_time.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
  <xsl:template match="data">
    <xsl:apply-templates select="blog" />
  </xsl:template>
	<xsl:template match="blog">
		<form action="" method="get" name="portal_form" id="bswh-marketing">
			<div id="bswh">
				<input type="hidden" name="searchType" value="keyword" />
				<xsl:call-template name="external_files" />
		    <link href="/css/public/blog.css" rel="stylesheet"/>
				<xsl:call-template name="public_blog" />
			</div>
		</form>
	</xsl:template>

	<xsl:template name="public_blog">
		<xsl:if test="string-length(/data/form/messagePublicFormIntro) &gt; 0">
			<div class="form-message form-intro">
				<xsl:value-of select="/data/form/messagePublicFormIntro" disable-output-escaping="yes" />
			</div>
		</xsl:if>
		<!--
    <ol class="breadcrumb">
      <li><a href="/calendar/list/{/data/calendar/id}">Home</a></li>
      <li class="active"><xsl:value-of select="/data/calendar/event/title" /></li>
    </ol>
		-->
		<div class="row" id="blog-main">
			<!--
			<div class="col-lg-3 col-md-3 col-sm-3">
				<xsl:call-template name="sidebar" />
			</div>
			-->
			<div class="col-lg-12 col-md-12 col-sm-12">
				<h1 class="form-group"><xsl:value-of select="/data/blog/title" /></h1>
				<xsl:call-template name="main" />
				<div class="provider">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></div>
			</div>
		</div>

		<xsl:if test="string-length(/data/form/messagePublicFormClosing) &gt; 0">
			<div class="form-message form-closing">
				<xsl:value-of select="/data/form/messagePublicFormClosing" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template name="main">
		<xsl:call-template name="top_nav" />
		<xsl:apply-templates select="topic" />
		<footer>
			<xsl:call-template name="social_media" />
		</footer>
	</xsl:template>
  <xsl:template match="topic">
    <article id="topic-{id}" class="entry-{position()}">
      <h1 class="topic-title {prettyUrl}">
        <a href="../detail/{../prettyUrl}?TOPIC_ID={id}">
          <xsl:value-of select="title" />
        </a>
      </h1>
      <date>
        <strong>
          <span class="topic-date">
            <span class="fa fa-calendar" />&#160;
            <xsl:call-template name="format_date">
              <xsl:with-param name="paramDate" select="publishDate" />
            </xsl:call-template>
          </span>
          <span class="topic-time">
            <span class="fa fa-clock-o" />&#160;
            <xsl:call-template name="format_time">
              <xsl:with-param name="publishTime" select="publishTime" />
            </xsl:call-template>
          </span>
        </strong>
      </date>
			<ul class="list-inline">
				<xsl:for-each select="tag">
					<li>
						<a class="label label-primary" href="../search?searchType=tag&amp;tagId={id}">
							<xsl:value-of select="label" />
						</a>
					</li>
				</xsl:for-each>
			</ul>
      <div class="topic-description"><xsl:value-of select="description" disable-output-escaping="yes" /></div>
    </article>
  </xsl:template>
</xsl:stylesheet>