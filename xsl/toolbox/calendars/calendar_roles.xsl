<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/calendar_variables.xsl" />
	<xsl:include href="includes/calendar_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="GENERAL" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
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
            <div class="form-group col-lg-4">
              <label for="CALENDAR_ROLE_EMAIL">Email Address</label>
              <input type="text" class="form-control" name="CALENDAR_ROLE_EMAIL" id="CALENDAR_ROLE_EMAIL" />
            </div>
              <div class="form-group col-lg-4">
                <label for="CALENDAR_ROLE_TYPE">Type of Role</label>
                <select class="form-control" name="CALENDAR_ROLE_TYPE" id="CALENDAR_ROLE_TYPE">
                  <option />
                  <option value="email">Email Recipient</option>
                  <option value="manager">Content Manager</option>
                  <option value="admin">Administrator</option>
                </select>
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
