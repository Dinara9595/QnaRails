$(document).on('turbolinks:load', function(){
    $('.questions').on('click', '.edit-question-link', e => {
        e.preventDefault();
        $(e.target).hide();
        const questionId = $(e.target).data('questionId');
        $('form#edit-question-' + questionId).removeClass('hidden');
    })
});