
// $(document).ready()

$(document).on('change','#usage_user_id', function () {//change majors when user changes school
  load_plans_of_users_dropdown();
});

// $(document).ready(load_plans_of_users_dropdown);//populate majors when page loads with first school


function load_plans_of_users_dropdown(){
    // var request = "/plans/find_majors_given_school_id?school_id=" //access controller of interest
    //     + $('#school_id_select').val();

    var request = "user/"+$('#usage_user_id').val()+"/plans"
    console.log(request)

    Rails.ajax({
        url: request,
        type: 'get',
        // data: $(this).serialize(),
        success: function(resp){
            console.log(resp)
            change_plans(resp)},
        error:function(err){console.log(err)}
    })


};

function change_plans(data) {
    $("#usage_plan_id").empty();//remove all previous majors
    console.log(data)
    for(i = 0;i<data.length;i++){
        console.log(data[i].id,data[i].name)
        $("#usage_plan_id").append(//add in an option for each major
            $("<option></option>").attr("value", data[i].id).text(data[i].name)
        );
    }
}



$(document).on('change','#usage_plan_id', function () {//change majors when user changes school
    console.log("changed the plans")
    load_features_of_plans_dropdown();
  });

  // $(document).ready(load_plans_of_users_dropdown);//populate majors when page loads with first school


  function load_features_of_plans_dropdown(){


      var request = "user/"+$('#usage_plan_id').val()+"/features"
    //   usages/user/:id/features
      console.log(request)

      Rails.ajax({
          url: request,
          type: 'get',
          // data: $(this).serialize(),
          success: function(resp){
              console.log(resp)
              change_features(resp,'usage_feature_id')},
          error:function(err){console.log(err)}
      })


  };

  function change_features(data,clas) {
      $("#"+clas).empty();//remove all previous majors
      console.log(data)
      for(i = 0;i<data.length;i++){
          console.log(data[i].id,data[i].name)
          $("#"+clas).append(//add in an option for each major
              $("<option></option>").attr("value", data[i].id).text(data[i].name)
          );
      }
  }
