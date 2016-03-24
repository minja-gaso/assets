<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="skin" />
	</xsl:template>
	<xsl:template match="skin">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="ROLES" />
			<input type="hidden" name="SKIN_ID" value="{/data/skin/id}" />
			<input type="hidden" name="ROLE_ID" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'ROLES'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Roles &amp; Privileges</h2>
				<xsl:call-template name="wizard" />
				<xsl:call-template name="messages" />
				<xsl:call-template name="help" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-default disabled" href="javascript:saveSkin();submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:skins();submitForm();">Back to Skins</a>
					<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Skin</a>
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
					<a href="javascript:switchTab('HTML');submitForm();">
						<span class="stepNumber">3</span>
						<span class="stepDesc text-small">Modify skin and app HTML</span>
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
				<label for="SKIN_ROLE_EMAIL">Email Address</label>
				<input type="text" class="form-control" name="SKIN_ROLE_EMAIL" id="SKIN_ROLE_EMAIL" />
			</div>
			<div class="form-group col-lg-5">
				<label for="SKIN_ROLE_TYPE">Type of Role</label>
				<div class="styled-select">
					<select class="form-control" name="SKIN_ROLE_TYPE" id="SKIN_ROLE_TYPE">
						<option />
						<option value="email">Email Recipient</option>
						<option value="manager">Content Manager</option>
						<option value="admin">Administrator</option>
					</select>
				</div>
			</div>
			<div class="form-group col-lg-2">
				<label for="SKIN_ROLE_ADD" class="invisible">Create Role</label>
				<div>
					<button class="btn btn-primary" name="SKIN_ROLE_ADD" id="SKIN_ROLE_ADD" onclick="javascript:addRole();submitForm();">Add User</button>
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
	<xsl:template name="all">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="ROLES" />
			<input type="hidden" name="SKIN_ID" value="{/data/skin/id}" />
			<input type="hidden" name="ROLE_ID" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="primary_navigation">
						<xsl:with-param name="SCREEN" select="'ROLES'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>Roles &amp; Privileges</h2>
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
								<a href="javascript:switchTab('HTML');submitForm();">
									<span class="stepNumber">3</span>
									<span class="stepDesc text-small">Modify skin and app HTML</span>
								</a>
							</li>
						</ul>
					</nav>
					<xsl:call-template name="messages" />
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
					<div class="row">
            <div class="form-group col-lg-5">
              <label for="SKIN_ROLE_EMAIL">Email Address</label>
              <input type="text" class="form-control" name="SKIN_ROLE_EMAIL" id="SKIN_ROLE_EMAIL" />
            </div>
            <div class="form-group col-lg-5">
              <label for="SKIN_ROLE_TYPE">Type of Role</label>
              <div class="styled-select">
								<select class="form-control" name="SKIN_ROLE_TYPE" id="SKIN_ROLE_TYPE">
	                <option />
	                <option value="email">Email Recipient</option>
	                <option value="manager">Content Manager</option>
	                <option value="admin">Administrator</option>
	              </select>
							</div>
            </div>
            <div class="form-group col-lg-2">
              <label for="SKIN_ROLE_ADD" class="invisible">Create Role</label>
              <div>
								<button class="btn btn-primary" name="SKIN_ROLE_ADD" id="SKIN_ROLE_ADD" onclick="javascript:addRole();submitForm();">Add User</button>
							</div>
            </div>
          </div>
					<hr  />
					<div class="row">
						<div class="form-group col-lg-4">
							<label for="SKIN_ROLE_EMAIL_RECIPIENTS">Current Email Recipients</label>
							<table class="table">
								<thead>
									<th class="col-xs-11">Email</th>
									<th class="col-xs-1 text-center">Delete</th>
								</thead>
								<tbody>
									<xsl:for-each select="/data/skin/role[type='email']">
										<tr>
											<th><xsl:value-of select="email" /></th>
											<th class="text-center"><a href="javascript:deleteRole('{id}');submitForm();"><span class="fa fa-trash" /></a></th>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
						<div class="form-group col-lg-4">
							<label for="SKIN_ROLE_MANAGERS">Current Content Managers</label>
							<table class="table">
								<thead>
									<th class="col-xs-11">Email</th>
									<th class="col-xs-1 text-center">Delete</th>
								</thead>
								<tbody>
									<xsl:for-each select="/data/skin/role[type='manager']">
										<tr>
											<th><xsl:value-of select="email" /></th>
											<th class="text-center"><a href="javascript:deleteRole('{id}');submitForm();"><span class="fa fa-trash" /></a></th>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
						<div class="form-group col-lg-4">
							<label for="SKIN_ROLE_ADMINS">Current Administrators</label>
							<table class="table">
								<thead>
									<th class="col-xs-11">Email</th>
									<th class="col-xs-1 text-center">Delete</th>
								</thead>
								<tbody>
									<xsl:for-each select="/data/skin/role[type='admin']">
										<tr>
											<th><xsl:value-of select="email" /></th>
											<th class="text-center"><a href="javascript:deleteRole('{id}');submitForm();"><span class="fa fa-trash" /></a></th>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
					</div>
					<div class="btn-toolbar btn-actions">
						<a class="btn btn-default" href="javascript:saveSkin();submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:skins();submitForm();">Back to Skins</a>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Form</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
