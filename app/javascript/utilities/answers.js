$(document).on('turbolinks:load', function(){
    $('.answers').on('click', '.edit-answer-link', e => {
        e.preventDefault();
        $(e.target).hide();
        const answerId = $(e.target).data('answerId');
        $('form#edit-answer-' + answerId).removeClass('hidden');
    })
});