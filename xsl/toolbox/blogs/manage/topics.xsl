<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/blog_variables.xsl" />
	<xsl:include href="../includes/blog_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="blog" />
	</xsl:template>
	<xsl:template match="blog">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="TOPICS" />
			<input type="hidden" name="BLOG_ID" value="{id}" />
			<input type="hidden" name="TOPIC_ID" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_content_navigation">
					<xsl:with-param name="SCREEN" select="'TOPICS'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group" id="top-actions">
					<div class="btn-toolbar">
						<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:blogs();submitForm();">Back to Blogs</a>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Blog</a>
					</div>
				</div>
				<h2>Topics for <em><xsl:value-of select="/data/blog/title" /></em></h2>
				<xsl:call-template name="wizard" />
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar">
					<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:blogs();submitForm();">Back to Blogs</a>
					<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Blog</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="wizard">
		<nav id="wizard">
			<h3>Quick Jumps</h3>
			<ul>
				<li>
					<a class="selected done" href="javascript:document.portal_form.COMPONENT_ID.value='6';switchTab('GENERAL');submitForm();" title="current page">
						<span class="stepNumber">1</span>
						<span class="stepDesc text-small">Provide basic info</span>
					</a>
				</li>
				<li>
					<a class="selected done" href="javascript:document.portal_form.COMPONENT_ID.value='6';switchTab('ROLES');submitForm();">
						<span class="stepNumber">2</span>
						<span class="stepDesc text-small">Assign access for other users</span>
					</a>
				</li>
				<li>
					<a class="selected" href="javascript:void(0);">
						<span class="stepNumber">3</span>
						<span class="stepDesc text-small">Start adding topics</span>
					</a>
				</li>
			</ul>
		</nav>
	</xsl:template>
	<xsl:template name="main">
		<xsl:if test="count(/data/blog/category) = 0">
			<div class="alert alert-info"><span class="fa fa-info-circle fa-lg">&#160;</span> Consider adding categories to better identify the type of event.</div>
		</xsl:if>
		<div class="form-group btn-group pull-right">
			<a class="btn btn-primary" href="javascript:createTopic();submitForm();"><span class="fa fa-blog"><span class="hide">Add New Topic</span></span>&#160;&#160;Add New Event</a>
		</div>
		<table class="table table-condensed">
			<thead>
				<tr>
					<th class="col-lg-1 col-md-1 col-sm-1 text-center">Start Date</th>
					<!--<th class="col-lg-1 col-md-1 col-sm-2 text-center">End Date</th>-->
					<th class="col-lg-1 col-md-1 col-sm-1 text-center">Published</th>
					<th class="col-lg-8 col-md-8 col-sm-8">Title</th>
					<th class="col-lg-1 col-md-1 col-sm-1 text-center">Delete</th>
					<th class="col-lg-1 col-md-1 col-sm-1 text-center">View</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="topic" />
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="topic">
		<xsl:variable name="id" select="id" />
		<tr class="event-row clickable" id="{$id}" data-target="collapsed-{$id}">
			<td class="text-center">
				<xsl:variable name="publishDate">
					<xsl:variable name="year" select="substring(publishDate, 1, 4)" />
					<xsl:variable name="month" select="substring(publishDate, 6, 2)" />
					<xsl:variable name="day" select="substring(publishDate, 9, 2)" />
					<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
				</xsl:variable>
				<xsl:value-of select="$publishDate" />
			</td>
			<td class="text-center">
				<span>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="published = 'true'">fa fa-check</xsl:when>
							<xsl:otherwise>fa fa-close</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
				</span>
			</td>
			<td>
				<a href="javascript:editTopic('{id}');submitForm();">
					<xsl:choose>
						<xsl:when test="string-length(title) &gt; 0">
							<span>
								<xsl:text><xsl:value-of select="title" /></xsl:text>
							</span>
						</xsl:when>
						<xsl:otherwise>
							<span class="bg-danger text-danger">Untitled Event</span>
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</td>
			<td class="text-center">
				<a href="javascript:deleteTopic('{id}');submitForm();">
					<span class="fa fa-trash fa-lg" />
				</a>
			</td>
			<td class="text-center">
				<a href="{concat($detailBaseUrl, '?eventID=', id)}" target="_blank">
					<span class="fa fa-search fa-lg" />
				</a>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
