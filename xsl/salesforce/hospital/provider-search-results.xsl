<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="paramGender" select="/root/paramGender" />
  <xsl:param name="paramSpecialty" select="/root/paramSpecialty" />
	<xsl:template match="/">
    <script>
      /*
      window.onload = function(){
        var formElements = document.querySelectorAll('form input[type=text], form select');
        for(var index = 0; index <xsl:text disable-output-escaping="yes">&lt;</xsl:text> formElements.length; index++)
        {
          var formElement = formElements[index];
          console.log(formElement.value);
          if(formElement.value.length <xsl:text disable-output-escaping="yes">&gt;</xsl:text> 0)
          {
            formElement.style.color = 'red';
          }
        }
      }*/
    </script>
    <form action="search-results" name="portal_form" method="get">
      <input type="hidden" name="PROFILE_URL" />
    	<fieldset>
    		<legend>Find a Provider</legend>
    		<div class="form-group">
    			<label class="ADDRESS">Search a provider near you</label>
    			<input type="text" class="form-control" name="ADDRESS" id="ADDRESS" placeholder="Enter address, city or zip code"/>
    		</div>
    		<div class="form-group">
    			<label for="PRACTICE">or search a known location</label>
    			<select class="form-control" name="PRACTICE" id="PRACTICE">
    				<option selected="selected" disabled="disabled" value="">Clinic or hospital</option>
    				<option value="">No preference</option>
            <xsl:for-each select="/root/Hospital/records">
              <xsl:sort select="Name" type="text" data-order="ascending" />
              <option value="{Name}">
                <xsl:if test="$paramSpecialty = Name">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="Name" />
              </option>
            </xsl:for-each>
    			</select>
    		</div>
    		<div class="form-group">
    			<label for="SPECIALTY">Choose a specialty or service</label>
    			<select class="form-control" name="SPECIALTY" id="SPECIALTY">
    				<option disabled="disabled" value="">Specialty or Service</option>
    				<option value="">No preference</option>
            <xsl:for-each select="/root/ClinicalServices/records">
              <xsl:sort select="Name" type="text" data-order="ascending" />
              <option value="{Name}">
                <xsl:if test="$paramSpecialty = Name">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="Name" />
              </option>
            </xsl:for-each>
    			</select>
    		</div>
    		<div class="form-group">
    			<label for="GENDER visually-hidden">Gender</label>
    			<select class="form-control" name="GENDER" id="GENDER">
    				<option disabled="disabled" value="">Gender</option>
    				<option value="">No preference</option>
    				<option value="F">
              <xsl:if test="$paramGender = 'F'">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:text>Female</xsl:text>
            </option>
    				<option value="M">
              <xsl:if test="$paramGender = 'M'">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:text>Male</xsl:text>
            </option>
    			</select>
    		</div>
    		<div class="form-group">
    			<button type="submit" class="btn btn-primary">Submit</button>
    		</div>
    	</fieldset>
    </form>
  	<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="root">
		<xsl:apply-templates select="records" />
    <xmp><xsl:copy-of select="." /></xmp>
	</xsl:template>
  <xsl:template match="records">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h2 class="panel-title">
          <a href="profile" onclick="javascript:document.portal_form.PROFILE_URL.value='{attributes/url}';"><xsl:value-of select="Name" /></a>
          <small class="pull-right">ID:&#160;<xsl:value-of select="Provider_ID__c" /></small>
        </h2>
        <p><small>REST API call: <xsl:value-of select="attributes/url" /></small></p>
      </div>
      <div class="panel-body">
        <h4>Clinical Services</h4>
        <ul class="list-inline">
          <xsl:for-each select="epicSpecialties/array">
            <li><xsl:value-of select="." /></li>
          </xsl:for-each>
        </ul>
        <xsl:if test="count(languages/array) &gt; 0">
          <hr/>
          <h4>Languages</h4>
          <ul class="list-inline">
            <xsl:for-each select="languages/array">
              <li><xsl:value-of select="." /></li>
            </xsl:for-each>
          </ul>
        </xsl:if>
      </div>
    </div>
  </xsl:template>
</xsl:stylesheet>
