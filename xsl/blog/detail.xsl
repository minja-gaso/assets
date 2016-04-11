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
				<div class="" id="app-container">
					<xsl:call-template name="external_files" />
					<xsl:call-template name="intro_message" />
					<xsl:call-template name="header" />
					<div class="clearfix" id="app-content">
						<xsl:call-template name="aside" />
						<xsl:call-template name="main" />
					</div>
					<xsl:call-template name="footer" />
					<xsl:call-template name="closing_message" />
				</div>
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
			<div class="col-sm-3">
				<xsl:call-template name="aside" />
			</div>
			<div class="col-sm-9">
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
		<main class="col-sm-9">
			<xsl:call-template name="breadcrumb" />
			<xsl:apply-templates select="topic" />
		</main>
	</xsl:template>
  <xsl:template match="topic">
    <article id="entry-{id}" class="entry-{position()}">
      <h1 class="entry-title">
        <xsl:value-of select="title" />
      </h1>
      <date>
        <span class="entry-date">
          <xsl:call-template name="format_date">
            <xsl:with-param name="paramDate" select="publishDate" />
          </xsl:call-template>
        </span>
        <span class="entry-time">
          <xsl:call-template name="format_time">
            <xsl:with-param name="publishTime" select="publishTime" />
          </xsl:call-template>
        </span>
      </date>
			<ul class="entry-tags list-inline">
				<xsl:for-each select="tag">
					<li>
						<a class="label label-primary" href="../search?searchType=tag&amp;tagId={id}">
							<xsl:value-of select="label" />
						</a>
					</li>
				</xsl:for-each>
			</ul>
			<xsl:if test="file[type='large']">
				<figure class="entry-large-image">
					<img src="/uploads/blog/{../id}/{id}/{file/name}" />
					<xsl:if test="string-length(file/name) &gt; 0">
						<figcaption><xsl:value-of select="file/name" /></figcaption>
					</xsl:if>
				</figure>
			</xsl:if>
      <div class="entry-article">
				<xsl:value-of select="article" disable-output-escaping="yes" />
			</div>
    </article>
  </xsl:template>
</xsl:stylesheet>
