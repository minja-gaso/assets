<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/blog_variables.xsl" />
	<xsl:include href="../includes/blog_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="GENERAL" />
			<input type="hidden" name="BLOG_ID" value="{/data/blog/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'GENERAL'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group hidden" id="top-actions">
					<a class="btn btn-default" href="javascript:saveBlog();submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:blogs();submitForm();">Back to Calendars</a>
					<a class="btn btn-default" href="{$listUrl}" target="_blank">View Calendar</a>
				</div>
				<h2>General Information</h2>
				<xsl:call-template name="wizard" />
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar">
					<a class="btn btn-default" href="javascript:saveBlog();submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:blogs();submitForm();">Back to Calendars</a>
					<a class="btn btn-default" href="{$listUrl}" target="_blank">View Calendar</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="wizard">
		<nav id="wizard">
			<h3>Quick Jumps</h3>
			<ul>
				<li>
					<a class="selected" href="javascript:void(0);" title="current page">
						<span class="stepNumber">1</span>
						<span class="stepDesc text-small">Provide basic info</span>
					</a>
				</li>
				<li>
					<a href="javascript:switchTab('ROLES');submitForm();">
						<span class="stepNumber">2</span>
						<span class="stepDesc text-small">Assign access for other users</span>
					</a>
				</li>
				<li>
					<a href="javascript:document.portal_form.COMPONENT_ID.value=4;editCalendar('{/data/blog/id}');submitForm();">
						<span class="stepNumber">3</span>
						<span class="stepDesc text-small">Start adding events</span>
					</a>
				</li>
			</ul>
		</nav>
	</xsl:template>
	<xsl:template name="main">
		<div class="row" id="title">
			<div class="form-group col-xs-12">
				<label for="BLOG_TITLE">Title</label>
				<input type="text" class="form-control" name="BLOG_TITLE" id="BLOG_TITLE" value="{/data/blog/title}" />
			</div>
		</div>
		<div class="row" id="url">
			<div class="form-group col-xs-12">
				<label for="BLOG_URL">Standard URL</label>
				<p class="help-block">If you do not care about SEO, feel free to link to this URL.</p>
				<input type="text" class="form-control" value="{$listUrlById}" disabled="disabled" readonly="readonly" />
			</div>
		</div>
		<div class="row" id="pretty-url">
			<div class="form-group col-xs-12">
				<label for="BLOG_PRETTY_URL">Pretty URL</label>
				<p class="help-block">SEO-friendly alternative to standard URLs that gives you control.  You may use alphanumeric characters, hyphens, underscores and periods.</p>
				<div class="input-group input-group-url">
					<span class="input-group-addon"><xsl:value-of select="concat(/data/environment/serverName, '/blog/list/')" /></span>
					<input type="text" class="form-control" name="BLOG_PRETTY_URL" id="BLOG_PRETTY_URL" value="{/data/blog/prettyUrl}" />
					<a href="{$listUrl}" class="input-group-addon" target="_blank"><span class="fa fa-external-link" /></a>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
