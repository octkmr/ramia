<?php

namespace App\Console\Commands\Develop;

use Illuminate\Console\Command;
use Illuminate\Database\DatabaseManager;

class Initialize extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:initialize';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = '初期化処理';

    public function __construct(
        private readonly DatabaseManager $db,
    ) {
        parent::__construct();
    }

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        $this->info('initialize app start --------------------------------');
        $this->info('');

        $this->info('migrate start --------------------------------');
        $this->call('migrate:fresh', ['--force']);
        $this->info('migrate end   --------------------------------');
        $this->info('');

        try {
            $this->db->transaction(function () {
                $this->info('seed start --------------------------------');
                $this->call('db:seed', ['--force']);
                $this->info('seed end   --------------------------------');
                $this->info('');

                $this->db->commit();
            });
        } catch (\Throwable $e) {
            $this->db->rollBack();
            $this->error($e->getMessage());
        }

        $this->info('initialize app end   --------------------------------');
    }
}
