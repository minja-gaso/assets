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

  <xsl:template name="sidebar">
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
  </xsl:template>
  <xsl:template name="external_files">
    <!-- Bootstrap -->
    <link href="/css/resources/bootstrap/styles/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" />
    <link href='https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300' rel='stylesheet' type='text/css' />
    <link href='https://fonts.googleapis.com/css?family=Source+Serif+Pro' rel='stylesheet' type='text/css' />
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
  <xsl:template name="top_nav">
    <ul class="list-inline" id="blog-toolbar">
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
      <li class="pull-right">
        <div id="search">
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
              <span class="offscreen">Search</span>
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
      </li>
    </ul>
  </xsl:template>
  <xsl:template name="advanced_search">
    <div class="row offscreen" id="advanced-search">
			<fieldset id="advanced-search-container">
				<legend>Advanced Search</legend>
				<div class="form-group">
					<label class="sr-only" for="ADVANCED_SEARCH_KEYWORD">Keyword(s)</label>
					<input type="text" class="form-control" name="ADVANCED_SEARCH_KEYWORD" id="ADVANCED_SEARCH_KEYWORD" placeholder="Enter keyword(s)" />
				</div>
				<div class="row">
					<div class="form-group col-sm-6">
						<label class="sr-only" for="ADVANCED_SEARCH_START_DATE">From</label>
						<input type="text" class="form-control" name="ADVANCED_SEARCH_START_DATE" id="ADVANCED_SEARCH_START_DATE" />
					</div>
					<div class="form-group col-sm-6">
						<label class="sr-only" for="ADVANCED_SEARCH_END_DATE">To</label>
						<input type="text" class="form-control" name="ADVANCED_SEARCH_END_DATE" id="ADVANCED_SEARCH_END_DATE" />
					</div>
				</div>
				<xsl:if test="count(/data/calendar/category) &gt; 0">
					<div class="form-group">
						<label>Category</label>
						<select class="form-control" name="ADVANCED_SEARCH_CATEGORY" id="ADVANCED_SEARCH_CATEGORY">
							<xsl:for-each select="/data/calendar/category">
								<option><xsl:value-of select="position()" /></option>
							</xsl:for-each>
						</select>
					</div>
				</xsl:if>
				<div class="text-center">
					<button class="btn btn-primary">Submit</button>
				</div>
			</fieldset>
		</div>
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
        <xsl:otherwise>
          <xsl:text>Search: <xsl:value-of select="/data/calendar/search/query" /></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <ol class="breadcrumb">
      <li><a href="/calendar/list/{/data/calendar/id}">Home</a></li>
      <li class="active"><xsl:value-of select="$currentView" /></li>
    </ol>
  </xsl:template>
</xsl:stylesheet>
