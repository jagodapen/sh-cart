document.querySelector("[data-form-prepend]").click(function(e) {
  var obj = document.querySelector(document.querySelector(this).attr("data-form-prepend"));
  obj.querySelector("input, select, textarea").each(function() {
    document.querySelector(this).attr("name", function() {
      return document.querySelector(this)
        .attr("name")
        .replace("new_record", new Date().getTime());
    });
  });
  obj.insertBefore(this);
  return false;
});
