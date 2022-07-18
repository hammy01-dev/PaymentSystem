
// $(document).ready()

$(document).on('change','#usage_user', function () {//change majors when user changes school
  load_plans_of_users_dropdown();
});

// $(document).ready(load_plans_of_users_dropdown);//populate majors when page loads with first school


function load_plans_of_users_dropdown(){
    var request = "/plans/find_majors_given_school_id?school_id=" //access controller of interest
        + $('#school_id_select').val();

    var request = "user/:id="+$('#usage_user').val()+"/plans"
    console.log(request)

    // var aj = $.ajax({
    //     url: request,
    //     type: 'get',
    //     data: $(this).serialize()
    // }).done(function (data) {
    //      change_majors(data);//modify the majors' dropdown
    // }).fail(function (data) {
    //      console.log('AJAX request has FAILED');
    // });
};
