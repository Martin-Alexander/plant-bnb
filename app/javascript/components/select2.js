import "select2";

export const setupSelect2 = () => {
  $(".select2").select2();
}

export const tearDownSelect2 = () => {
  $(".select2").val(null).trigger('change')
}