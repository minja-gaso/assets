<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/form_variables.xsl" />
	<xsl:include href="includes/form_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="form" />
	</xsl:template>
	<xsl:template match="form">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="ROLES" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="ROLE_ID" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'ROLES'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group" id="top-actions">
					<div class="btn-toolbar">
						<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
				<h2>Analytics Information</h2>
				<xsl:call-template name="wizard" />
				<xsl:call-template name="messages" />
				<xsl:call-template name="help" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar">
					<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
					<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="wizard">
		<nav id="wizard">
			<h3>Quick Jumps</h3>
			<ul>
				<li>
					<a class="selected done" href="javascript:switchTab('GENERAL');submitForm();" title="go to general page">
						<div class="stepNumber">1</div>
						<span class="stepDesc text-small">Provide basic info</span>
					</a>
				</li>
				<li>
					<a class="selected" href="javascript:void(0);" title="current page">
						<div class="stepNumber">2</div>
						<span class="stepDesc text-small">Assign access for other users</span>
					</a>
				</li>
				<li>
					<a href="javascript:document.portal_form.COMPONENT_ID.value=4;editForm('{/data/form/id}');submitForm();">
						<div class="stepNumber">3</div>
						<span class="stepDesc text-small">Start adding events</span>
					</a>
				</li>
			</ul>
		</nav>
	</xsl:template>
	<xsl:template name="help">
		<div class="help-block">
			<dl>
				<dt>Email Recipient</dt>
				<dd>Will receive emails when non-admin creates a new event.  They will be able to determine whether to publish the event or place under further review.</dd>
			</dl>
			<dl>
				<dt>Content Manager</dt>
				<dd>Granted the ability to create, edit and delete events for the calendar.</dd>
			</dl>
			<dl>
				<dt>Administrator</dt>
				<dd>All the abilities of a <em>Content Manager</em> and access to <strong>Setup</strong>.</dd>
			</dl>
		</div>
	</xsl:template>
	<xsl:template name="main">
		<div class="row">
      <div class="form-group col-lg-5">
        <label for="FORM_ROLE_EMAIL">Email Address</label>
        <input type="text" class="form-control" name="FORM_ROLE_EMAIL" id="FORM_ROLE_EMAIL" />
      </div>
      <div class="form-group col-lg-5">
        <label for="FORM_ROLE_TYPE">Type of Role</label>
        <select class="form-control" name="FORM_ROLE_TYPE" id="FORM_ROLE_TYPE">
          <option />
          <option value="email">Email Recipient</option>
          <option value="manager">Content Manager</option>
          <option value="admin">Administrator</option>
        </select>
      </div>
      <div class="form-group col-lg-2">
        <label for="FORM_ROLE_ADD" class="invisible">Create Role</label>
        <div>
					<button class="btn btn-primary" name="FORM_ROLE_ADD" id="FORM_ROLE_ADD" onclick="javascript:addRole();submitForm();">Add User</button>
				</div>
      </div>
    </div>
		<hr  />
		<div class="row">
			<div class="form-group col-lg-4">
				<xsl:call-template name="roles">
					<xsl:with-param name="type" select="'email'" />
					<xsl:with-param name="label_id" select="'SKIN_ROLE_EMAIL_RECIPIENTS'" />
					<xsl:with-param name="label_text" select="'Current Email Recipients'" />
				</xsl:call-template>
			</div>
			<div class="form-group col-lg-4">
				<xsl:call-template name="roles">
					<xsl:with-param name="type" select="'manager'" />
					<xsl:with-param name="label_id" select="'SKIN_ROLE_MANAGERS'" />
					<xsl:with-param name="label_text" select="'Current Content Managers'" />
				</xsl:call-template>
			</div>
			<div class="form-group col-lg-4">
				<xsl:call-template name="roles">
					<xsl:with-param name="type" select="'admin'" />
					<xsl:with-param name="label_id" select="'SKIN_ROLE_ADMINS'" />
					<xsl:with-param name="label_text" select="'Current Administrators'" />
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
