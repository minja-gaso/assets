function submitForm()
{
  document.portal_form.submit();
}
function createCalendar()
{
  document.portal_form.ACTION.value = 'CREATE_CALENDAR';
  submitForm();
}
function saveCalendar()
{
  document.portal_form.ACTION.value = 'SAVE_CALENDAR';
  submitForm();
}
function calendars()
{
  document.portal_form.SCREEN.value = 'LIST';
  document.portal_form.CALENDAR_ID.value = 0;
  submitForm();
}
function createEvent()
{
  document.portal_form.ACTION.value = 'CREATE_EVENT';
  document.portal_form.SCREEN.value = 'EVENT';
  submitForm();
}
function editEvent(id)
{
  document.portal_form.SCREEN.value = 'EVENT';
  document.portal_form.EVENT_ID.value = id;
  submitForm();
}
function saveEvent()
{
  document.portal_form.ACTION.value = 'SAVE_EVENT';
  submitForm();
}
function editCalendar(id)
{
  if(document.portal_form.COMPONENT_ID.value == 3)
  {
    document.portal_form.SCREEN.value = 'GENERAL';
  }
  else if(document.portal_form.COMPONENT_ID.value == 4)
  {
    document.portal_form.SCREEN.value = 'EVENTS';
  }
  document.portal_form.CALENDAR_ID.value = id;
  submitForm();
}
function deleteCalendar(id)
{
  document.portal_form.ACTION.value = 'DELETE_CALENDAR';
  document.portal_form.CALENDAR_ID.value = id;
  submitForm();
}
function eventListScreen()
{
  document.portal_form.SCREEN.value = 'EVENTS';
  document.portal_form.EVENT_ID.value = 0;
  submitForm();
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
 *  Inner screen functionality
 */
function switchTab(screen)
{
  document.portal_form.ACTION.value = 'SAVE_FORM';
  document.portal_form.SCREEN.value = screen;
  submitForm();
}

/*
 *  Question List
 */
function createQuestion()
{
  document.portal_form.ACTION.value = 'CREATE_QUESTION';
  submitForm();
}
function deleteQuestion(id)
{
  document.portal_form.ACTION.value = 'DELETE_QUESTION';
  document.portal_form.QUESTION_ID.value = id;
  submitForm();
}
function insertQuestion(id)
{
  document.portal_form.ACTION.value = 'INSERT_QUESTION';
  document.portal_form.QUESTION_ID.value = id;
  submitForm();
}
function swapQuestions(swapDirection, number)
{
  document.portal_form.ACTION.value = swapDirection;
  document.portal_form.QUESTION_NUMBER.value = number;
  submitForm();
}
function questionReorder(id, direction)
{
  document.portal_form.ACTION.value = direction;
  document.portal_form.QUESTION_ID.value = id;
  submitForm();
}
function editQuestion(id, screen)
{
  document.portal_form.SCREEN.value = screen;
  document.portal_form.QUESTION_ID.value = id;
  submitForm();
}
function saveQuestion(id)
{
  document.portal_form.ACTION.value = 'SAVE_QUESTION';
  submitForm();
}
function saveQuestions()
{
  document.portal_form.ACTION.value = 'SAVE_QUESTIONS';
  submitForm();
}
function saveAnswers()
{
  document.portal_form.ACTION.value = 'SAVE_ANSWERS';
  submitForm();
}
function insertPageBreak(id)
{
  document.portal_form.ACTION.value = 'INSERT_PAGE_BREAK';
  document.portal_form.QUESTION_NUMBER.value = id;
  submitForm();
}
function deletePageBreak(id)
{
  document.portal_form.ACTION.value = 'DELETE_PAGE_BREAK';
  document.portal_form.PAGE_BREAK_ID.value = id;
  submitForm();
}
function removePageBreakAfter(id)
{
  document.portal_form.ACTION.value = 'REMOVE_PAGE_BREAK';
  document.portal_form.PAGE_TO_DELETE.value = id;
  submitForm();
}
function addAnswers(){
    document.portal_form.ACTION.value = 'ADD_ANSWERS';
    submitForm();
}
function deleteAnswer(id)
{
  document.portal_form.ACTION.value = 'DELETE_ANSWER';
  document.portal_form.ANSWER_ID.value = id;
  submitForm();
}
function createScore()
{
  document.portal_form.ACTION.value='CREATE_SCORE';
  submitForm();
}
function editScore(id)
{
  document.portal_form.SCREEN.value = 'EDIT_SCORE';
  document.portal_form.SCORE_ID.value = id;
  submitForm();
}
function saveScore()
{
  document.portal_form.ACTION.value = 'SAVE_SCORE';
  submitForm();
}
function deleteScore(id)
{
  document.portal_form.ACTION.value = 'DELETE_SCORE';
  document.portal_form.SCORE_ID.value = id;
  submitForm();
}
function editMessage(messageName)
{
  document.portal_form.SCREEN.value = 'EDIT_MESSAGE';
  document.portal_form.MESSAGE_NAME.value = messageName;
  submitForm();
}
function formScores()
{
  document.portal_form.SCREEN.value = 'SCORES';
  submitForm();
}
function saveMessage()
{
  document.portal_form.ACTION.value = 'SAVE_MESSAGE';
  submitForm();
}
function formMessages()
{
  document.portal_form.SCREEN.value = 'MESSAGES';
  submitForm();
}

/*
 *  Public form functions
 */
function changePage(page)
{
  document.portal_form.CURRENT_PAGE.value=page;
  document.portal_form.ACTION.value='SUBMIT_FORM';
  submitForm();
}

/*

function swapQuestions2(swapDirection, moveUp, moveDown)
{
  document.portal_form.ACTION.value = swapDirection;
  document.portal_form.MOVE_QUESTION_NUMBER_UP.value = moveUp;
  document.portal_form.MOVE_QUESTION_NUMBER_DOWN.value = moveDown;
  submitForm();
}
*/
