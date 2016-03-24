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
			<input type="hidden" name="SCREEN" value="ANALYTICS" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="primary_navigation">
						<xsl:with-param name="SCREEN" select="'ANALYTICS'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<div class="form-group hidden" id="top-actions">
						<div class="btn-toolbar">
							<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
							<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
							<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
						</div>
					</div>
					<h2>Roles &amp; Privileges</h2>
					<xsl:call-template name="messages" />
					<xsl:call-template name="main" />
					<div class="btn-toolbar">
						<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:formListScreen();submitForm();">Back to Forms</a>
						<a class="btn btn-default" href="{$webformUrlToUse}" target="_blank">View Form</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<div class="row">
			<div class="form-group col-sm-4 col-xs-12">
				<label for="START_DATE">Start Date</label>
				<div class="input-group">
					<input type="text" class="form-control datepicker" name="START_DATE" id="START_DATE" placeholder="YYYY-MM-DD" readonly="readonly" maxlength="4" />
					<span class="input-group-addon" onclick="this.previousSibling.focus();"><span class="fa fa-calendar"><span class="sr-only">start date picker</span></span></span>
				</div>
			</div>
			<div class="form-group col-sm-4 col-xs-12 col-sm-offset-1">
				<label for="END_DATE">End Date</label>
				<div class="input-group">
					<input type="text" class="form-control datepicker" name="END_DATE" id="END_DATE" placeholder="YYYY-MM-DD" readonly="readonly" />
					<span class="input-group-addon" onclick="this.previousSibling.focus();"><span class="fa fa-calendar"><span class="sr-only">start date picker</span></span></span>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12 col-md-12">
				<div class="form-group nth-column">
					<label class="block" style="display:block;">Summary</label>
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:viewAnalytics('html', 'summary');"><span class="fa fa-file-code-o" /> HTML</a>
						<a class="btn btn-default" href="javascript:viewAnalytics('pdf', 'summary');"><span class="fa fa-file-pdf-o" /> PDF</a>
					</div>
					<script>
					function viewAnalytics(paramView, paramType)
					{
						var viewUrl = '<xsl:value-of select="/data/environment/serverName" />/toolbox/survey/' + paramView + '/' + paramType + '/<xsl:value-of select="/data/form/id" />';
						var startDate = document.getElementById('START_DATE').value;
						var endDate = document.getElementById('END_DATE').value;
						viewUrl = viewUrl + '?START_DATE=' + startDate + '<xsl:text disable-output-escaping="yes">&amp;</xsl:text>END_DATE=' + endDate;
						window.open(viewUrl, '_blank');
					}

					function defaultDate()
					{
						var startDate = document.getElementById('START_DATE');
						var endDate = document.getElementById('END_DATE');

						var today = new Date();
						var todayDD = today.getDate();
						var todayMM = today.getMonth() + 1;
						var todayYYYY = today.getFullYear();

						if(todayDD <xsl:text disable-output-escaping="yes">&lt;</xsl:text> 10)
						{
							todayDD = '0' + todayDD;
						}
						if(todayMM <xsl:text disable-output-escaping="yes">&lt;</xsl:text> 10)
						{
							todayMM = '0' + todayMM;
						}

						var todayStr = todayYYYY + '-' + todayMM + '-' + todayDD;
						startDate.value = todayStr;
						endDate.value = todayStr;
					}
					window.onload = defaultDate;
					</script>
					<script src="/js/form-datepicker.js">//</script>
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
