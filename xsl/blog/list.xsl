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
				<script>
					var forms = document.getElementsByTagName('form');
					if(forms.length == 1)
					{
						forms[0].name = 'portal_form';
						forms[0].method = 'get';
					}
				</script>
				<input type="hidden" name="searchType" value="keyword" />
				<xsl:call-template name="external_files" />
		    <link href="/css/public/blog.css" rel="stylesheet"/>
				<div class="" id="blog-container">
					<xsl:call-template name="public_blog" />
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
		<div class="row" id="blog-main">
			<div class="col-xs-12">
				<h1 class="form-group"><xsl:value-of select="/data/blog/title" /></h1>
				<xsl:call-template name="main" />
				<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
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
      <div class="topic-description"><xsl:value-of select="description" disable-output-escaping="yes" /></div>
    </article>
  </xsl:template>
</xsl:stylesheet>
