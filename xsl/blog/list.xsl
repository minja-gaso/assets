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
	<!--
		<xsl:apply-templates select="topic" />
	-->
		<div id="bswh-marketing">
	    <form action="" method="get" name="portal_form" id="bswh-form">
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
			</form>
		</div>
  </xsl:template>

	<xsl:template name="main">
		<main class="col-sm-9">
			<xsl:call-template name="breadcrumb" />
			<xsl:choose>
				<xsl:when test="count(topic) &gt; 0">
					<xsl:apply-templates select="topic" />
				</xsl:when>
				<xsl:otherwise>
					<p>No topics currently exist.</p>
				</xsl:otherwise>
			</xsl:choose>
		</main>
	</xsl:template>

  <xsl:template match="topic">
    <article id="entry-{id}" class="entry entry-{position()}">
      <h1 class="entry-title">
        <a href="../detail/{../prettyUrl}?TOPIC_ID={id}">
          <xsl:value-of select="title" />
        </a>
      </h1>
      <date>
        <span class="entry-date">
					<!--
	          <span class="fa fa-calendar" />&#160;
					-->
          <xsl:call-template name="format_date">
            <xsl:with-param name="paramDate" select="publishDate" />
          </xsl:call-template>
        </span>
        <span class="entry-time">
					<!--
	          <span class="fa fa-clock-o" />&#160;
					-->
          <xsl:call-template name="format_time">
            <xsl:with-param name="publishTime" select="publishTime" />
          </xsl:call-template>
        </span>
      </date>
      <section class="entry-summary">
				<xsl:value-of select="summary" disable-output-escaping="yes" />
			</section>
    </article>
  </xsl:template>
</xsl:stylesheet>
