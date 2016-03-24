<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="messages">
    <xsl:if test="count(/data/message) &gt; 0">
      <xsl:key name="message-type" match="message" use="type" />
      <!--
        Info messages
      -->
      <xsl:for-each select="/data/message[type='info']">
        <xsl:choose>
          <xsl:when test="count(/data/message[type='info'])  &gt; 1">
            <ul class="alert alert-info">
              <li><xsl:value-of select="label" /></li>
            </ul>
          </xsl:when>
          <xsl:when test="count(/data/message[type='info']) = 1">
            <div class="alert alert-info">
              <span class="fa fa-info-circle fa-lg">&#160;</span>&#160;<xsl:value-of select="label" />
            </div>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
      <!--
        Error messages
      -->
      <xsl:choose>
        <xsl:when test="count(/data/message[type='error'])  &gt; 0">
          <div class="alert alert-danger">
            <span class="fa fa-exclamation-circle fa-lg">&#160;</span>&#160;The following errors exist:
            <ul>
              <xsl:for-each select="/data/message[type='error']">
                <li><xsl:value-of select="label" /></li>
              </xsl:for-each>
            </ul>
          </div>
        </xsl:when>
        <xsl:when test="count(/data/message[type='error']) = 1">
          <div class="alert alert-danger">
            <span class="fa fa-exclamation-circle fa-lg">&#160;</span>&#160;<xsl:value-of select="label" />
          </div>
        </xsl:when>
      </xsl:choose>

      <!--
        Success messages
      -->
      <xsl:for-each select="/data/message[type='success']">
        <xsl:choose>
          <xsl:when test="count(/data/message[type='success'])  &gt; 1">
            <ul class="alert alert-success">
              <li><xsl:value-of select="label" /></li>
            </ul>
          </xsl:when>
          <xsl:when test="count(/data/message[type='success']) = 1">
            <div class="alert alert-success">
              <span class="fa fa-exclamation-circle fa-lg">&#160;</span>&#160;<xsl:value-of select="label" />
            </div>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <xsl:template name="roles">
		<xsl:param name="type" />
		<xsl:param name="label_id" />
		<xsl:param name="label_text" />
		<label for="{$label_id}"><xsl:value-of select="$label_text" /></label>
		<xsl:choose>
			<xsl:when test="count(role[type=$type]) &gt; 0">
				<table class="table table-bordered table-condensed">
					<thead>
						<th class="col-xs-11">Email</th>
						<th class="col-xs-1 text-center">Delete</th>
					</thead>
					<tbody>
						<xsl:for-each select="role[type=$type]">
							<tr>
								<th><xsl:value-of select="email" /></th>
								<th class="text-center"><a href="javascript:deleteRole('{id}');submitForm();"><span class="fa fa-trash" /></a></th>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<p>None</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
