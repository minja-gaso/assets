function submitForm()
{
  document.portal_form.submit();
}
function createForm()
{
  document.portal_form.ACTION.value = 'CREATE_FORM';
  submitForm();
}
function createFormSubmit()
{
  document.portal_form.ACTION.value = 'INSERT_FORM';
  submitForm();
}
function editForm(id)
{
  document.portal_form.SCREEN.value = 'GENERAL';
  document.portal_form.FORM_ID.value = id;
  submitForm();
}
function deleteForm(id)
{
  document.portal_form.ACTION.value = 'DELETE_FORM';
  document.portal_form.FORM_ID.value = id;
  submitForm();
}
function formListScreen()
{
  document.portal_form.SCREEN.value = 'LIST';
  document.portal_form.FORM_ID.value = 0;
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
