#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use feature qw/ say /;

use Pod::Simple::HTML;
use HTML::TreeBuilder;

my $pod;

{
    local $/;
    $pod = <DATA>;
}

my $p = Pod::Simple::HTML->new;
$p->output_string(\my $html);
$p->parse_string_document($pod);
say Dumper (HTML::TreeBuilder->new_from_content($html));

__DATA__
=encoding utf8
=pod

=head1 NAME

Easy To Miss - 놓치기 쉬운 Generic 개념들

=head1 A Generic Class is Shared by All Its Invocations

=begin html

<pre><code class="java">
 List<String> l1 = new ArrayList<String>();
 List<Integer> l2 = new ArrayList<Integer>();
 System.out.println(l1.getClass() == l2.getClass());
</code></pre>

=end html

위의 코드는 어떤 값을 출력할까?

답은 B<YES>.

제네릭 클래스의 모든 인스턴스는 type parameter 와 관계없이
동일한 run-time 클래스를 갖는다.

제네릭 클래스란 허용된 모든 타입에 대해서 같은 동작을
수행하는 것을 말한다.

따라서 모든 static 변수와 static 메소드도 마찬가지로 모든
인스턴스에 공유된다. 이것이 static 메소드와 static initializer 내에서, 또는 static 변수의 선언과 초기화 시에 type parameter 가 참조
될 수 없는 이유다.

=begin html

<pre><code class="java">
 class Gen<T> {
     T t1;

     // Error :
     // non-static type variable T cannot be referenced
     // from a static context
     static T t2;

     public void methodA(T t) {
         t.toString();
     }

     public static void MethodB() {
         // Illegal
         T t;
     }

     // Illegal
     public static void SomeStaticMethod(T in) {}

 }
</code></pre>

=end html

=head1 Casts and InstanceOf

제네릭 클래스는 모든 인스턴스에 의해 공유되기 때문에 특정 타입에
대해 B<instanceof> 를 사용하는 것은 의미가 없다.

=begin html

<pre><code class="java">
 Collection cs = new ArrayList<String>();

 // Illegal.
 if (cs instanceof Collection<String>) { ... }
</code></pre>

=end html

cast 도 마찬가지다.

=begin html

<pre><code class="java">
 // Unchecked warning,
 Collection<String> cstr = (Collection<String>) cs;
</code></pre>

=end html

runtime system 의 확인이 없을 것이기 때문에 unchecked warning
이 발생한다.

변수에 대해서도 마찬가지다.



=cut

