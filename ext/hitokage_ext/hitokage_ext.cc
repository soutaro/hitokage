#include <ruby.h>
#include "double-conversion/double-conversion.h"

using namespace double_conversion;

static int flags = DoubleToStringConverter::EMIT_TRAILING_DECIMAL_POINT | DoubleToStringConverter::EMIT_TRAILING_ZERO_AFTER_POINT | DoubleToStringConverter::EMIT_POSITIVE_EXPONENT_SIGN;
static double_conversion::DoubleToStringConverter converter(flags, "Infinity", "NaN", 'e', -4, 15, 6, 0);
static char buffer[256];
static double_conversion::StringBuilder builder(buffer, sizeof(buffer));

static VALUE hitokage_to_s(VALUE self) {
  double value = RFLOAT_VALUE(self);

  builder.Reset();
  bool result = converter.ToShortest(value, &builder);
  if (result) {
    return rb_str_new(buffer, builder.position());
  } else {
    return Qnil;
  }
}

extern "C" void Init_hitokage_ext() {
  rb_define_method(rb_cFloat, "hitokage_to_s", RUBY_METHOD_FUNC(hitokage_to_s), 0);
}

