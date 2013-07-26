TMXMerger

Usage: 

java -jar <TMXMerger> [source=LL(-CC)] <tmx1> <tmx2> [<tmx3> ...] <output>

Where:

<TMXMerger> is the name of the jar file (e.g. TMXMerger-1.1.jar)

<tmx1>, <tmx2>, etc. are the names of the TMX files to be merged

<output> is the desired name of the merged file to be created

If no source language is specified, the source language as
specified in the source language attribute in the first TMX
file will be used. To specify a source language, add the
option source=LL(-CC), where LL is the language code, and
CC is the country code (optional). This *must* be the first
argument.

Java must be installed.
