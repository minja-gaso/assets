<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="GENERAL" />
			<input type="hidden" name="SKIN_ID" value="{/data/skin/id}" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="primary_navigation">
						<xsl:with-param name="SCREEN" select="'GENERAL'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>General Information</h2>
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
								<a href="javascript:switchTab('HTML');submitForm();">
									<span class="stepNumber">3</span>
									<span class="stepDesc text-small">Modify skin and app HTML</span>
								</a>
							</li>
						</ul>
					</nav>
					<xsl:call-template name="messages" />
					<div class="row" id="title">
						<div class="form-group col-xs-12">
							<label for="SKIN_TITLE">Title</label>
							<input type="text" class="form-control" name="SKIN_TITLE" id="SKIN_TITLE" value="{/data/skin/title}" />
						</div>
					</div>
					<div class="row" id="skin">
						<div class="form-group col-lg-6 col-md-6 col-sm-6">
							<label for="SKIN_URL">Skin URL</label>
							<!--
							<p class="help-block">If you wish to have a skin around the survey, enter a URL.</p>
							-->
							<input type="text" class="form-control" name="SKIN_URL" id="SKIN_URL">
								<xsl:choose>
									<xsl:when test="string-length(/data/skin/skinUrl) &gt; 0">
										<xsl:attribute name="value">
											<xsl:value-of select="/data/skin/skinUrl" />
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="placeholder">
											<xsl:text>http://www.sw.org/location-search</xsl:text>
										</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
							</input>
						</div>
						<div class="form-group col-lg-6 col-md-6 col-sm-6">
							<label for="SKIN_SELECTOR">Skin CSS Selector</label>
							<!--
							<p class="help-block">Element ID or class in which to insert content.</p>
							-->
							<input type="text" class="form-control" name="SKIN_SELECTOR" id="SKIN_SELECTOR">
								<xsl:choose>
									<xsl:when test="string-length(/data/skin/skinSelector) &gt; 0">
										<xsl:attribute name="value">
											<xsl:value-of select="/data/skin/skinSelector" />
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="placeholder">
											<xsl:text>#ls-gen8-ls-area-body</xsl:text>
										</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
							</input>
						</div>
					</div>
					<div class="row" id="editable">
						<div class="form-group col-xs-12">
							<label for="SKIN_EDITABLE">Editable</label>
							<div class="form-inline">
								<label>
									<input type="radio" name="SKIN_EDITABLE" id="SKIN_EDITABLE_TRUE" value="true">
										<xsl:if test="/data/skin/editable = 'true'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>&#160;
									<span class="font-normal">
										<xsl:text>Yes</xsl:text>
									</span>
								</label>
								<label>
									<input type="radio" name="SKIN_EDITABLE" id="SKIN_EDITABLE_FALSE" value="false">
										<xsl:if test="/data/skin/editable = 'false'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>&#160;
									<span class="font-normal">
										<xsl:text>No</xsl:text>
									</span>
								</label>
							</div>
						</div>
					</div>
					<div class="btn-toolbar btn-actions">
						<a class="btn btn-default" href="javascript:saveSkin();submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:skins();submitForm();">Back to Skins</a>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Skin</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
