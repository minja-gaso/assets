<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/calendar_variables.xsl" />
	<xsl:include href="includes/calendar_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="ROLES" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<input type="hidden" name="ROLE_ID" />
			<!-- survey content -->
			<div class="row">
				<div class="col-lg-12 bordered-area">
					<nav>
						<xsl:call-template name="primary_navigation">
							<xsl:with-param name="SCREEN" select="'ROLES'" />
						</xsl:call-template>
					</nav>
					<h2>Roles &amp; Privileges</h2>
					<xsl:call-template name="messages" />
					<div class="row">
            <div class="form-group col-lg-5">
              <label for="CALENDAR_ROLE_EMAIL">Email Address</label>
              <input type="text" class="form-control" name="CALENDAR_ROLE_EMAIL" id="CALENDAR_ROLE_EMAIL" />
            </div>
            <div class="form-group col-lg-5">
              <label for="CALENDAR_ROLE_TYPE">Type of Role</label>
              <select class="form-control" name="CALENDAR_ROLE_TYPE" id="CALENDAR_ROLE_TYPE">
                <option />
                <option value="email">Email Recipient</option>
                <option value="manager">Content Manager</option>
                <option value="admin">Administrator</option>
              </select>
            </div>
            <div class="form-group col-lg-2">
              <label for="CALENDAR_ROLE_ADD">Add Role</label>
              <div>
								<button class="btn btn-primary" name="CALENDAR_ROLE_ADD" id="CALENDAR_ROLE_ADD" onclick="javascript:addRole();">Add Role</button>
							</div>
            </div>
          </div>
					<hr  />
					<div class="row">
						<div class="form-group col-lg-4">
							<label for="CALENDAR_ROLE_EMAIL_RECIPIENTS">Current Email Recipients</label>
							<table class="table">
								<thead>
									<th class="col-lg-11">Email</th>
									<th class="col-lg-1 text-center">Delete</th>
								</thead>
								<tbody>
									<xsl:for-each select="/data/calendar/role[type='email']">
										<tr>
											<th><xsl:value-of select="email" /></th>
											<th class="text-center"><a href="javascript:deleteRole('{id}');"><span class="fa fa-trash" /></a></th>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
						<div class="form-group col-lg-4">
							<label for="CALENDAR_ROLE_MANAGERS">Current Content Managers</label>
							<table class="table">
								<thead>
									<th class="col-lg-11">Email</th>
									<th class="col-lg-1 text-center">Delete</th>
								</thead>
								<tbody>
									<xsl:for-each select="/data/calendar/role[type='manager']">
										<tr>
											<th><xsl:value-of select="email" /></th>
											<th class="text-center"><a href="javascript:deleteRole('{id}');"><span class="fa fa-trash" /></a></th>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
						<div class="form-group col-lg-4">
							<label for="CALENDAR_ROLE_ADMINS">Current Administrators</label>
							<table class="table">
								<thead>
									<th class="col-lg-11">Email</th>
									<th class="col-lg-1 text-center">Delete</th>
								</thead>
								<tbody>
									<xsl:for-each select="/data/calendar/role[type='admin']">
										<tr>
											<th><xsl:value-of select="email" /></th>
											<th class="text-center"><a href="javascript:deleteRole('{id}');"><span class="fa fa-trash" /></a></th>
										</tr>
									</xsl:for-each>
								</tbody>
							</table>
						</div>
					</div>
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:saveCalendar();">Save</a>
						<a class="btn btn-default" href="javascript:calendars();">Back to Calendars</a>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Form</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
