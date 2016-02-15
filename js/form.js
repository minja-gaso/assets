function createForm()
{
  document.portal_form.ACTION.value = 'CREATE_FORM';
}
function createFormSubmit()
{
  document.portal_form.ACTION.value = 'INSERT_FORM';
}
function editForm(id)
{
  document.portal_form.SCREEN.value = 'GENERAL';
  document.portal_form.FORM_ID.value = id;
}
function deleteForm(id)
{
  document.portal_form.ACTION.value = 'DELETE_FORM';
  document.portal_form.FORM_ID.value = id;
}
function formListScreen()
{
  document.portal_form.SCREEN.value = 'LIST';
  document.portal_form.FORM_ID.value = 0;
}
function toggleCheckboxes(self, name)
{
  var isChecked = false;
  if(self.checked)
  {
    isChecked = true;
  }
  var elements = document.getElementsByName(name);
  for(var index = 0; index < elements.length; index++)
  {
    var element = elements[index];
    element.checked = isChecked;
  }
}

/*
 *  Question List
 */
function createQuestion()
{
  document.portal_form.ACTION.value = 'CREATE_QUESTION';

}
function deleteQuestion(id)
{
  document.portal_form.ACTION.value = 'DELETE_QUESTION';
  document.portal_form.QUESTION_ID.value = id;

}
function insertQuestion(id)
{
  document.portal_form.ACTION.value = 'INSERT_QUESTION';
  document.portal_form.QUESTION_ID.value = id;

}
function swapQuestions(swapDirection, number)
{
  document.portal_form.ACTION.value = swapDirection;
  document.portal_form.QUESTION_NUMBER.value = number;

}
function questionReorder(id, direction)
{
  document.portal_form.ACTION.value = direction;
  document.portal_form.QUESTION_ID.value = id;

}
function editQuestion(id, screen)
{
  document.portal_form.SCREEN.value = screen;
  document.portal_form.QUESTION_ID.value = id;

}
function saveQuestion(id)
{
  document.portal_form.ACTION.value = 'SAVE_QUESTION';

}
function saveQuestions()
{
  document.portal_form.ACTION.value = 'SAVE_QUESTIONS';

}
function saveAnswers()
{
  document.portal_form.ACTION.value = 'SAVE_ANSWERS';

}
function insertPageBreak(id)
{
  document.portal_form.ACTION.value = 'INSERT_PAGE_BREAK';
  document.portal_form.QUESTION_NUMBER.value = id;

}
function deletePageBreak(id)
{
  document.portal_form.ACTION.value = 'DELETE_PAGE_BREAK';
  document.portal_form.PAGE_BREAK_ID.value = id;

}
function removePageBreakAfter(id)
{
  document.portal_form.ACTION.value = 'REMOVE_PAGE_BREAK';
  document.portal_form.PAGE_TO_DELETE.value = id;

}
function addAnswers(){
    document.portal_form.ACTION.value = 'ADD_ANSWERS';

}
function deleteAnswer(id)
{
  document.portal_form.ACTION.value = 'DELETE_ANSWER';
  document.portal_form.ANSWER_ID.value = id;

}
function createScore()
{
  document.portal_form.ACTION.value='CREATE_SCORE';

}
function editScore(id)
{
  document.portal_form.SCREEN.value = 'EDIT_SCORE';
  document.portal_form.SCORE_ID.value = id;

}
function saveScore()
{
  document.portal_form.ACTION.value = 'SAVE_SCORE';

}
function deleteScore(id)
{
  document.portal_form.ACTION.value = 'DELETE_SCORE';
  document.portal_form.SCORE_ID.value = id;

}
function editMessage(messageName)
{
  document.portal_form.SCREEN.value = 'EDIT_MESSAGE';
  document.portal_form.MESSAGE_NAME.value = messageName;

}
function formScores()
{
  document.portal_form.SCREEN.value = 'SCORES';

}
function saveMessage()
{
  document.portal_form.ACTION.value = 'SAVE_MESSAGE';

}
function formMessages()
{
  document.portal_form.SCREEN.value = 'MESSAGES';

}

/*
 *  Public form functions
 */
function changePage(page)
{
  document.portal_form.CURRENT_PAGE.value=page;
  document.portal_form.ACTION.value='SUBMIT_FORM';

}
