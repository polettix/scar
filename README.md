**scar** is a pure-Perl no-dependency utility to support file transfers via HTTP.

## USAGE

          scar [--usage] [--help] [--man] [--version]

          scar [--host|-h hostname]
               [--port|-p port]
               [--root|-r root-directory]

## EXAMPLES

          # serve current directory, dynamic port, any local address
          me@myserver$ scar
          server started, you can connect to http://myserver:54321/

          # set a specific port
          me@myserver$ scar -p 8080
          server started, you can connect to http://myserver:8080/

          # bind to localhost only, on specific port
          me@myserver$ scar -p 8080 -h localhost
          server started, you can connect to http://127.0.0.1:8080/

          # set the path to be served, can be a file or a directory
          me@myserver$ scar -r shared-stuff.tar.gz
          server started, you can connect to http://myserver:53412/
          me@myserver$ scar -r /tmp
          server started, you can connect to http://myserver:35142/

## DESCRIPTION

**scar** helps you when you want to quickly share a local directory or file
with someone remotely, e.g. when you don’t want (or can not) send it by
email.

**scar** requires that there is the possibility for the remote end to set
up a TCP connection to your machine, otherwise it’s pretty dull. This
connection might be over a SSH tunnel, anyway, so don’t feel defeated
too early.

The most simple use case is when you want to share all the files (and
subdirectories) of the directory you’re currently in:

          me@myserver$ scar
          server started, you can connect to http://myserver:54321/

Now you can provide the printed URI to your peer to let her start the
download.

Note that `myserver` might be something that is not reachable from the
outside. If this is the case, you have to substitute `myserver` with an
IP address that can be used to reach your machine.

Another popular use case - possibly more than the previous one - is
when you just want to share a file. In this case you only need `--root`:

    me@myserver$ scar -r shared-stuff.tar.gz
    server started, you can connect to http://myserver:53412/

The same goes if you want to share a whole directory that is not the
current one:

    me@myserver$ scar -r /tmp
    server started, you can connect to http://myserver:35142/

If you have only a limited range of available ports - e.g. because you
have some firewall in between, or a NAT - you can fix the port instead
of leaving the dynamic allocation:

    me@myserver$ scar -p 8080
    server started, you can connect to http://myserver:8080/

Another interesting option is the possibility to set the local address
where you want to listen, e.g. restrict the access to `localhost` only:

    me@myserver$ scar -p 8080 -h localhost
    server started, you can connect to http://127.0.0.1:8080/

This restricts the access only to those that have access to localhost.
How can this be useful? For example, suppose that both you and your
peer have access to a shared server, you could set up this:

    me@myserver$ ssh -R 54321:localhost:8080 me@sharedserver

and your peer could do this:

    you@yourserver$ ssh -L 33333:localhost:54321 you@sharedserver

and then, with all this circus going on:

    you@yourserver$ curl http://localhost:33333/

will tunnel the peer’s request through her ssh connection to the shared
server, which will in turn retunnel it through your connection from
myserver.

In case it’s OK you can spare the peer the tunnel and set a bind
address when connecting:

    me@myserver$ ssh -R public-ip:54321:localhost:8080 me@sharedserver

In this case, the tunnel will instruct the sshd daemon on sharedserver
to listen to any available address instead of localhost only.

## LICENSE AND COPYRIGHT

Copyright (c) 2011, Flavio Poletti "flavio@polettix.it". All rights
reserved.

This script is free software; you can redistribute it and/or modify it
under the Artistic License 2.0.

Questo script è software libero: potete ridistribuirlo e/o modificarlo
nei termini della Artistic License 2.0.

## DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT
WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER
PARTIES PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE LIABLE
TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE
SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
DAMAGES.

## NEGAZIONE DELLA GARANZIA

Poiché questo software viene dato con una licenza gratuita, non c’è
alcuna garanzia associata ad esso, ai fini e per quanto permesso dalle
leggi applicabili. A meno di quanto possa essere specificato altrove,
il proprietario e detentore del copyright fornisce questo software
"così com’è" senza garanzia di alcun tipo, sia essa espressa o
implicita, includendo fra l’altro (senza pero limitarsi a questo)
eventuali garanzie implicite di commerciabilita e adeguatezza per uno
scopo particolare. L’intero rischio riguardo alla qualità ed alle
prestazioni di questo software rimane a voi. Se il software dovesse
dimostrarsi difettoso, vi assumete tutte le responsabilita ed i costi
per tutti i necessari servizi, riparazioni o correzioni.

In nessun caso, a meno che ciò non sia richiesto dalle leggi vigenti o
sia regolato da un accordo scritto, alcuno dei detentori del diritto di
copyright, o qualunque altra parte che possa modificare, o
redistribuire questo software cosi come consentito dalla licenza di cui
sopra, potrà essere considerato responsabile nei vostri confronti per
danni, ivi inclusi danni generali, speciali, incidentali o
conseguenziali, derivanti dall’utilizzo o dall’incapacità di utilizzo
di questo software. Ciò include, a puro titolo di esempio e senza
limitarsi ad essi, la perdita di dati, l’alterazione involontaria o
indesiderata di dati, le perdite sostenute da voi o da terze parti o un
fallimento del software ad operare con un qualsivoglia altro software.
Tale negazione di garanzia rimane in essere anche se i dententori del
copyright, o qualsiasi altra parte, è stata avvisato della possibilità
di tali danneggiamenti.

Se decidete di utilizzare questo software, lo fate a vostro rischio e
pericolo. Se pensate che i termini di questa negazione di garanzia non
si confacciano alle vostre esigenze, o al vostro modo di considerare un
software, o ancora al modo in cui avete sempre trattato software di
terze parti, non usatelo. Se lo usate, accettate espressamente questa
negazione di garanzia e la piena responsabilita per qualsiasi tipo di
danno, di qualsiasi natura, possa derivarne.
