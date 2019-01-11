use ExtUtils::MakeMaker;
WriteMakefile(
    NAME      => 'Win32::Travis',
    PREREQ_PM => {
        'URI::db' => 0,
    }
);
