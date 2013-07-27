package POD2::RU;
use utf8;
use strict;
use warnings;
use base 'Exporter';
use base 'POD2::Base';

our $VERSION = '5.18.0.1.01';

our @EXPORT = qw(print_pod print_pods);

# Versions list
sub pod_info {
    {
        perl       => '5.18.0.1',
        perlintro  => '5.18.0.1',
        perlrun    => '5.18.0.1',
        a2p        => '5.18.0.1',
        perlbook   => '5.18.0.1',
        perldoc    => '5.18.0.1',
        perlpragma => '5.18.0.1',
        perlstyle  => '5.18.0.1',
        perlcheat  => '5.18.0.1',
        perlnewmod  => '5.18.0.1',
    };
}

# String for perldoc with -L switch
sub search_perlfunc_re {
    return 'Список функций Perl';
}

# Print information about a pod file
sub print_pod {
    my $self = shift;

    my @args = @_ ? @_ : @ARGV;

    unless ( ref $self ) {
        if ( defined $self ) {
            if ( $self ne __PACKAGE__ ) {
                unshift @args, $self;
                $self = __PACKAGE__;
            }
        }
        else {
            $self = __PACKAGE__;
        }
    }

    my $pods = $self->pod_info;

    while (@args) {
        ( my $pod = lc( shift @args ) ) =~ s/\.pod$//;
        if ( exists $pods->{$pod} ) {
            print
"\t'$pod' переведены на русский Perl $pods->{$pod}\n";
        }
        else {
            print "\t'$pod' еще не переведены\n";
        }
    }
}

# Print list of translated pods
sub print_pods {
    my $self = @_ ? shift : __PACKAGE__;

    $self->SUPER::print_pods;
}

1;

__END__
=encoding utf8

=head1 ИМЯ

POD2::RU - Perl Документация по-русски

=head1 СИНТАКСИС

  $ perldoc POD2::RU::<название_pod>

  $ perl -MPOD2::ES -e print_pods
  $ perl -MPOD2::ES -e print_pod <nombre_pod1> [<nombre_pod2> ...]

  use POD2::ES;
  print_pods();
  print_pod('pod_foo', 'pod_baz');

  use POD2::ES;
  my $pod2 = POD2::ES->new();
  $pod2->print_pods();
  $pod2->print_pod('perlfunc');
                                                                                          

=head1 ОПИСАНИЕ

Этот модуль содержит документы перевода Perl документации на русский​​, проект находиться здесь L<https://github.com/mishin/perldoc-ru>. 

После установки пакета, вы можете использовать следующую команду, чтобы получить документацию:

  $ perldoc POD2::RU::<название_pod>

Начиная с версии 3.14 Pod::Perldoc разрешено использовать следующий синтаксис:

  $ perldoc -L RU <название_pod>
  $ perldoc -L RU -f <функция>
  $ perldoc -L RU -q <регулярное выражение P+F>

Модификатор  C<-L> определяет код языка перевода. Если пакет C<POD2::E<lt>idiomaE<gt>> не существует, то модификатор не применяется, perldoc сообщит об отсутствии документации.

Для ленивых можно добавить псевдоним (alias):

  perldoc-ru="perldoc -L RU"

, чтобы избежать того, чтобы писать модификатор  C<-L> каждый раз:

  $ perldoc-ru perlre
  $ perldoc-ru -f map

Начиная с версии 3.15 F<Pod::Perldoc> вы можете использовать переменную среды PERLDOC_POD2 . Если эта переменная установлена ​​в '1 ', perldoc осуществляет поиск pod документации на языке, указанном в переменной LC_ALL, LANG или LC_LANG. Или, вы можете установить значение "ru", который будет указывать на документацию на русском языке. Например,

       export PERLDOC_POD2="ru"
       perldoc perl

Обратите внимание, что пересмотр был 3.14 в L<Pod::Perldoc|Pod::Perldoc> (Входит в Perl 5.8.7 и Perl 5.8.8), которая включала вариант C<-L>.
Если у вас есть предыдущие установки Perl (за исключением E<gt>= 5.8.1), обновить модуль L<Pod::Perldoc|Pod::Perldoc> до версии 3.14.
Perl 5.10 содержит эту функцию.


=head1 API

Пакет экспортирует следующие функции:

=over 4

=item * C<new>

Была добавлена ​​для совместимости с C<perldoc> Perl 5.10.1.
L<Pod::Perldoc> используется для возврата перевода имени пакета.

=item * C<pod_dirs>

Была добавлена ​​для совместимости с C<perldoc> Perl 5.10.1.
L<Pod::Perldoc> использует ее для определения, где искать переведенные файлы.

=item * C<print_pods>

Выводит все переведенные части и оригинальную версию Perl.

=item * C<print_pod>

Выводит на экран оригинальнуя версию Perl для всех переведенных частей, переданых в качестве аргументов.

=item * C<search_perlfunc_re>

F<Pod/Perldoc.pm> Вызовите этот метод, чтобы определить, что нужно искать в perlfunc.pod для того, чтобы пропустить введение и найти положение, где она встречает определение функции по запросу пользователей C<perldoc> с помощью  C<-f>.

=back


= Head1 ПРИМЕЧАНИЯ ПО ПЕРЕВОДУ

Для этого проекта мы приняли следующие решения:

=over

=item * Не используйте акцентированных символов в именах переменных и функций из примеров кода

Вполне можно использовать UTF-8 (вы просто должны кодировать программу как UTF-8 и добавить  "use utf8;" в первую очередь).

Более того, в тех системах, с древней системой визуализации текста, такие как терминалы командной строки можно потерять акценты. В большинстве случаев было обусловлено наличием одного из вариантов groff (программа используется командами man и perldoc ), которые не поддерживают символов. В документах HTML не должно быть проблем.


=item Не переводятся термины "array" и "hash"

Если учесть, что Perl'у уже  более 20 лет, и подавляющее большинство книг, доступных на этой ESTN на английском языке, не удивительно, что русскоязычные сообщества будут ссылаться на эти типы данных по имени в английском языке. Есть возможные переводов, таких, как "матрица", "список" для "array" или "словарь" для "hash", но его использование не распространяется, поэтому, мы предпочли использовать свое оригинальное название. Мы считаем, что это облегчит чтение документации.


=item * Используйте нейтральный Русский

=back


=head1 АВТОРЫ

=over

=item * Анатолий Шарифулин (Tech Lead), C< sharifulin + sharifulin at gmail.com >

=item * Николай Мишин (Language Lead), C< mishin + pod2ru at gmail.com, mi at ya.ru >

=item * Алексей Суриков (Language), C< KSURi>

=item * Михаил Любимов (Language), C< mikhail.lyubimov >

=item * Дмитрий Константинов (Language), C< Dim_K >

=item * Евгений Баранов (Language), C< Baranov >

=item * Динар Жамалиев (Language), C< zhdinar >

=back

=head1 ПРОЕКТ

Для получения дополнительной информации о проекте в L<https://github.com/mishin/perldoc-ru>.


=head1 СМОТРИТЕ ТАКЖЕ

L<POD2::ES>, L<POD2::PT_BR>, L<POD2::IT>, L<POD2::FR>, L<POD2::LT>.


=head1 ПОЖЕРТВОВАНИЕ

Из-за высокой трудоемкости работ и долгих лет жизни проект перевода документации Perl требует постоянных усилий, что доступно только для сильных духов и альтруистов.
Авторы не требую, но ни отвергают помощь в виде денег, книг, сыра и продуктов из свинины (можно хамон;) ), или даже поездки в Полинезию для снижение утомления и сохранения высокго боевого духа команды. Мы приглашаем всех.



=head1 ОШИБКИ

Вы можете сообщить ошибки (bugs) или запросить по электронной почте функциональность C<bug-pod2-ru at rt.cpan.org> или веб-интерфейс на L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=POD2-RU> или мне на почту mi at ya.ru . Вы можете сообщить об обнаруженных ошибках в автоматическую систему rt или запросить новую функциональность или просто попросить перевести документацию к модулю.


=head1 ПОДДЕРЖКА

Для просмотра документации в этом модуле, используйте команду Perldoc.

    perldoc POD2::RU


Вы также можете найти информацию о:

=over 4

=item * RT: системы отслеживания ощибок для CPAN

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=POD2-RU>

=item * AnnoCPAN: аннотированная документация CPAN

L<http://annocpan.org/dist/POD2-RU>

=item * Рейтинги CPAN

L<http://cpanratings.perl.org/d/POD2-RU>

=item * Поиск CPAN модулей

L<http://search.cpan.org/dist/POD2-RU/>

=back


=head1 БЛАГОДАРНОСТЬ

Авторы хотели бы выразить свою благодарность команде разработчиков OmegaT, инструмента, который используется для перевода.

Проект OmegaT: L<http://omegat.org/>


=head1 ЛИЦЕНЗИИ И АВТОРСКИЕ ПРАВА

Copyright (C) 2011-2013 Команда Perl по-русски, Moscow-pm.

Данная программа является свободным программным обеспечением, вы можете распространять и изменять его в соответствии с условиями общественной лицензии GNU General, опубликованной Фондом свободного программного обеспечения, или Artistic License.

См. http://dev.perl.org/licenses/, чтобы получить дополнительные сведения.


=cut
