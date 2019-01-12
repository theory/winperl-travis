use ExtUtils::MakeMaker;
WriteMakefile(
    NAME         => 'Win32::Travis',
    VERSION_FROM => 'lib/Win32/Travis.pm',
    PREREQ_PM    => {
        'URI::db' => 0,
    }
);
