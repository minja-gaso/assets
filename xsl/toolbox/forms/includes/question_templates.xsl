<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="question">
    <div class="form-group">
      <label for="QUESTION_HEADER">Heading</label>
      <input id="QUESTION_HEADER" type="hidden" name="QUESTION_HEADER" value="{/data/form/question/header}"/>
      <trix-editor input="QUESTION_HEADER"></trix-editor>
    </div>
    <div class="form-group">
      <label for="QUESTION_LABEL">Label</label>
      <input type="text" class="form-control" name="QUESTION_LABEL" id="QUESTION_LABEL" value="{label}" />
    </div>
		<div class="form-group">
			<label for="QUESTION_REQUIRED">Required</label>
			<div>
				<label class="font-normal no-margin">
					<input type="radio" name="QUESTION_REQUIRED" id="QUESTION_REQUIRED_TRUE" value="true">
						<xsl:if test="required = 'true'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input>&#160;
					<xsl:text>Yes</xsl:text>
				</label>
			</div>
			<div>
				<label class="font-normal no-margin">
					<input type="radio" name="QUESTION_REQUIRED" id="QUESTION_REQUIRED_FALSE" value="false">
						<xsl:if test="required = 'false'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input>&#160;
					<xsl:text>No</xsl:text>
				</label>
			</div>
		</div>
  </xsl:template>
  <xsl:template match="question" mode="text">
    <div class="form-group">
      <label for="QUESTION_DEFAULT_ANSWER">Default Answer</label>
      <xsl:choose>
        <xsl:when test="type = 'text'">
          <input type="text" class="form-control" name="QUESTION_DEFAULT_ANSWER" id="QUESTION_DEFAULT_ANSWER" placeholder="Lorem ipsum dollinar." value="{defaultAnswer}" />
        </xsl:when>
        <xsl:when test="type = 'textarea'">
          <textarea class="form-control" name="QUESTION_DEFAULT_ANSWER" id="QUESTION_DEFAULT_ANSWER" placeholder="Lorem ipsum dollinar.">
            <xsl:choose>
              <xsl:when test="string-length(defaultAnswer) = 0">
                <xsl:text>&#x0A;</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="defaultAnswer" />
              </xsl:otherwise>
            </xsl:choose>
          </textarea>
        </xsl:when>
      </xsl:choose>
    </div>
    <xsl:if test="type = 'text'">
			<div class="form-group">
				<label for="QUESTION_FILTER">Filter</label>
				<div>
					<label class="font-normal no-margin">
						<input type="radio" name="QUESTION_FILTER" id="QUESTION_FILTER_NONE" value="none">
							<xsl:if test="filter = 'none'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>&#160;
						<xsl:text>None</xsl:text>
					</label>
				</div>
				<div>
					<label class="font-normal no-margin">
						<input type="radio" name="QUESTION_FILTER" id="QUESTION_FILTER_DATE" value="date">
							<xsl:if test="filter = 'date'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>&#160;
						<xsl:text>Date</xsl:text>
					</label>
				</div>
				<div>
					<label class="font-normal no-margin">
						<input type="radio" name="QUESTION_FILTER" id="QUESTION_FILTER_EMAIL" value="email" xxdisabled="disabled">
							<xsl:if test="filter = 'email'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>&#160;
						<xsl:text>Email</xsl:text>
					</label>
				</div>
				<div>
					<label class="font-normal no-margin">
						<input type="radio" name="QUESTION_FILTER" id="QUESTION_FILTER_PHONE" value="phone" disabled="disabled">
							<xsl:if test="filter = 'phone'">
								<xsl:attribute name="checked">checked</xsl:attribute>
							</xsl:if>
						</input>&#160;
						<xsl:text>Phone Number</xsl:text>
					</label>
				</div>
			</div>
		</xsl:if>
  </xsl:template>
  <xsl:template name="answers">
    <div class="form-group">
      <div class="row">
        <div class="col-sm-8">
          <label>Add Answer(s)</label>
          <textarea class="form-control" name="ANSWER_ADD" id="ANSWER_ADD" rows="3">
            <xsl:text>&#x0A;</xsl:text>
          </textarea>
        </div>
        <div class="col-sm-4">
          <fieldset>
            <legend>Delimiter</legend>
            <div>
              <label class="font-normal no-margin">
                <input type="radio" name="ANSWER_ADD_FILTER" value="carriage" checked="checked" />
                Carriage Return
              </label>
            </div>
            <div>
              <label class="font-normal no-margin">
                <input type="radio" name="ANSWER_ADD_FILTER" value="comma" />
                Comma Separated
              </label>
            </div>
            <div>
              <label class="font-normal no-margin">
                <input type="radio" name="ANSWER_ADD_FILTER" value="tab" />
                Tab Delimited
              </label>
            </div>
            <a class="btn btn-default add-answers" href="javascript:addAnswers();submitForm();">Add Answers</a>
          </fieldset>
        </div>
      </div>
    </div>
    <div class="form-group">
      <table class="table table-condensed table-striped">
        <thead>
          <tr>
            <th class="col-sm-11">Label</th>
            <th class="col-sm-1 text-center">Delete</th>
          </tr>
        </thead>
        <tbody>
          <xsl:choose>
            <xsl:when test="count(question/possibleAnswer) &gt; 0">
              <xsl:for-each select="question/possibleAnswer">
                <tr>
                  <th><xsl:value-of select="label" /></th>
                  <td class="text-center"><a href="javascript:deleteAnswer('{id}');"><span class="fa fa-trash fa-lg" /></a></td>
                </tr>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <tr>
                <td class="bg-danger text-danger" colspan="2">This question <strong>should</strong> have answers but does not.</td>
              </tr>
            </xsl:otherwise>
          </xsl:choose>
        </tbody>
      </table>
    </div>
  </xsl:template>
</xsl:stylesheet>
