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
      <h1><xsl:value-of select="/data/blog/title" /></h1>
      <div id="app-search">
        <input type="text" />
        <input type="button" value="Go" />
      </div>
    </header>
  </xsl:template>

  <xsl:template name="intro_message">
		<xsl:if test="string-length(/data/form/messagePublicFormIntro) &gt; 0">
			<div class="form-message form-intro">
				<xsl:value-of select="/data/form/messagePublicFormIntro" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template name="footer">
		<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
	</xsl:template>

	<xsl:template name="closing_message">
		<xsl:if test="string-length(/data/form/messagePublicFormClosing) &gt; 0">
			<div class="form-message form-closing">
				<xsl:value-of select="/data/form/messagePublicFormClosing" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>

  <xsl:template name="aside">
    <aside class="col-sm-3">
      <!--
      <h3>Search</h3>
      <xsl:call-template name="search"/>
    -->
      <h3>Categories</h3>
      <ul class="list-unstyled">
        <li><a href="#">Lorem</a></li>
        <li><a href="#">Ipsum</a></li>
        <li><a href="#">Donor</a></li>
      </ul>
      <!--
      <h3>Share With</h3>
      <ul class="list-unstyled">
        <li><xsl:call-template name="icon"><xsl:with-param name="label" select="'rss'" /></xsl:call-template></li>
        <li><xsl:call-template name="icon"><xsl:with-param name="label" select="'twitter'" /></xsl:call-template></li>
        <li><xsl:call-template name="icon"><xsl:with-param name="label" select="'facebook'" /></xsl:call-template></li>
        <li><xsl:call-template name="icon"><xsl:with-param name="label" select="'linkedin'" /></xsl:call-template></li>
        <li><xsl:call-template name="icon"><xsl:with-param name="label" select="'google-plus'" /></xsl:call-template></li>
        <li><xsl:call-template name="icon"><xsl:with-param name="label" select="'pinterest'" /></xsl:call-template></li>
        <li><xsl:call-template name="icon"><xsl:with-param name="label" select="'flickr'" /></xsl:call-template></li>
      </ul>
    -->
      <xsl:if test="count(/data/calendar/category) &gt; 0">
        <h3>Categories</h3>
        <ul class="list-group">
          <xsl:for-each select="/data/calendar/category">
            <li class="list-group-item">
              <a href="/calendar/search/{/data/calendar/prettyUrl}?searchType=category&amp;categoryId={id}">
                <xsl:value-of select="label" />
              </a>
            </li>
          </xsl:for-each>
        </ul>
      </xsl:if>
    </aside>
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
  <xsl:template name="search">
    <div id="search">
      <label for="searchKeyword" class="hidden">Search</label>
      <div class="col-xs-12 input-group">
        <xsl:variable name="attributeName">
          <xsl:choose>
            <xsl:when test="string-length(/data/calendar/search/query) &gt; 0">value</xsl:when>
            <xsl:otherwise>placeholder</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="attributeValue">
          <xsl:choose>
            <xsl:when test="string-length(/data/calendar/search/query) &gt; 0">
              <xsl:value-of select="/data/calendar/search/query" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'Search'" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <input type="text" class="form-control" name="searchKeyword" id="searchKeyword" size="25">
          <xsl:attribute name="{$attributeName}"><xsl:value-of select="$attributeValue" /></xsl:attribute>
        </input>
        <a class="input-group-addon" onclick="javascript:document.portal_form.searchType.value='keyword';document.portal_form.action='/calendar/search/{/data/calendar/prettyUrl}';document.portal_form.submit();">
          <span class="fa fa-search" />
          <span class="offscreen hidden">Search</span>
        </a>
      </div>
      <script type="text/javascript">
        var keyword = document.getElementById('searchKeyword');
        keyword.addEventListener('keyup', function(e){
          var code = (e.keyCode ? e.keyCode : e.which);
          if(code == 13) {
            this.nextSibling.click();
          }
        });
      </script>
    </div>
  </xsl:template>
  <xsl:template name="social_media">
    <ul class="list-inline" id="social-media">
      <li>
        <a class="btn btn-social-icon btn-rss" href="/calendar/rss/{/data/calendar/prettyUrl}">
          <span class="fa fa-rss"></span>
        </a>
      </li>
      <li>
        <a class="btn btn-social-icon btn-twitter">
          <span class="fa fa-twitter"></span>
        </a>
      </li>
      <li>
        <a class="btn btn-social-icon btn-facebook">
          <span class="fa fa-facebook"></span>
        </a>
      </li>
      <li>
        <a class="btn btn-social-icon btn-linkedin">
          <span class="fa fa-linkedin"></span>
        </a>
      </li>
      <li>
        <a class="btn btn-social-icon btn-google">
          <span class="fa fa-google"></span>
        </a>
      </li>
      <li>
        <a class="btn btn-social-icon btn-pinterest">
          <span class="fa fa-pinterest"></span>
        </a>
      </li>
      <li>
        <a class="btn btn-social-icon btn-flickr">
          <span class="fa fa-envelope"></span>
        </a>
      </li>
    </ul>
  </xsl:template>

  <xsl:template name="breadcrumb">
    <xsl:variable name="currentView">
      <xsl:choose>
        <xsl:when test="/data/calendar/search/categoryId > 0">
          <xsl:text>Category: <xsl:value-of select="/data/calendar/category[id=$categoryId]/label" /></xsl:text>
        </xsl:when>
        <xsl:when test="/data/calendar/search/tagId > 0">
          <xsl:text>Tag: <xsl:value-of select="/data/calendar/event/tag[id=$tagId]/label" /></xsl:text>
        </xsl:when>
        <xsl:when test="/data/environment/screenName = 'DETAIL'">
          <xsl:text><xsl:value-of select="/data/blog/topic/title" /></xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Search: <xsl:value-of select="/data/calendar/search/query" /></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <div class="btn-group btn-breadcrumb">
      <a href="/blog/list/{/data/blog/prettyUrl}" class="btn btn-default">Home</a>
      <a class="btn btn-default"><xsl:value-of select="$currentView" /></a>
    </div>
  </xsl:template>
</xsl:stylesheet>
