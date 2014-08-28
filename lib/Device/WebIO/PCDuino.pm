# Copyright (c) 2014  Timm Murray
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, 
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright 
#       notice, this list of conditions and the following disclaimer in the 
#       documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.
package Device::WebIO::PCDuino;
$Device::WebIO::PCDuino::VERSION = '0.001';
# ABSTRACT: Device::WebIO implementation for the pcDuino
use v5.12;
use Moo;
use namespace::clean;
use Device::PCDuino ();


sub BUILDARGS
{
    my ($class, $args) = @_;

    #$args->{pwm_bit_resolution} = 8;
    #$args->{pwm_max_int}        = 2 ** $args->{pwm_bit_resolution};
    $args->{input_pin_count}    = 18;
    $args->{output_pin_count}   = 18;
    #$args->{pwm_pin_count}      = 1;
    # TODO
    # 6 bits for ADC 0 and 1, but 12 for the rest
    #$args->{adc_bit_resolution} = 12;
    #$args->{adc_max_int}        = 2 ** $args->{adc_bit_resolution};
    # TODO
    # 2 Volts for ADC 0 and 1, but 3.3V for the rest
    #$args->{adc_volt_ref}       = 3.3;
    #$args->{adc_pin_count}      = 6;

    return $args;
}


has 'input_pin_count', is => 'ro';
with 'Device::WebIO::Device::DigitalInput';

sub set_as_input
{
    my ($self, $pin) = @_;
    Device::PCDuino::set_input( $pin );
    return 1;
}

sub input_pin
{
    my ($self, $pin) = @_;
    my $in = Device::PCDuino::input( $pin );
    return $in;
}


has 'output_pin_count', is => 'ro';
with 'Device::WebIO::Device::DigitalOutput';

sub set_as_output
{
    my ($self, $pin) = @_;
    Device::PCDuino::set_output( $pin );
    return 1;
}

sub output_pin
{
    my ($self, $pin, $val) = @_;
    Device::PCDuino::output( $pin, $val );
    return 1;
}


# TODO PWM
#has 'pwm_pin_count',      is => 'ro';
#has 'pwm_bit_resolution', is => 'ro';
#has 'pwm_max_int',        is => 'ro';
#with 'Device::WebIO::Device::PWM';
#
#sub pwm_output_int
#{
#}


# TODO ADC
#has 'adc_max_int',        is => 'ro';
#has 'adc_bit_resolution', is => 'ro';
#has 'adc_volt_ref',       is => 'ro';
#has 'adc_pin_count',      is => 'ro';
#with 'Device::WebIO::Device::ADC';
#
#sub adc_input_int
#{
#}


# TODO
#with 'Device::WebIO::Device::SPI';
#with 'Device::WebIO::Device::I2C';
#with 'Device::WebIO::Device::Serial';
#with 'Device::WebIO::Device::VideoStream';

1;
__END__


=head1 NAME

  Device::WebIO::PCDuino - Access PCDuino pins via Device::WebIO

=head1 SYNOPSIS

    use Device::WebIO;
    use Device::WebIO::PCDuino;
    
    my $webio = Device::WebIO->new;
    my $pcduino = Device::WebIO::PCDuino->new({
    });
    $webio->register( 'foo', $pcduino );
    
    my $value = $webio->digital_input( 'foo', 0 );

=head1 DESCRIPTION

Access the PCDuino's pins using Device::WebIO.

After registering this with the main Device::WebIO object, you shouldn't need 
to access anything in the PCDuino object.  All access should go through the 
WebIO object.

=head1 IMPLEMENTED ROLES

=over 4

=item * DigitalOutput

=item * DigitalInput

=back

=head1 LICENSE

Copyright (c) 2014  Timm Murray
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are 
permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of 
      conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of
      conditions and the following disclaimer in the documentation and/or other materials 
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS 
OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut
