<?php
/**
 * File name: SecureDeletes.php
 * Last modified: 17/06/21, 3:44 PM
 * Author: NearCraft - https://codecanyon.net/user/nearcraft
 * Copyright (c) 2021
 */

namespace App\Traits;

trait SecureDeletes
{
    /**
     * Delete only when there is no reference to other models.
     *
     * @param array $relations
     */
    public function secureDelete(String ...$relations)
    {
        $hasRelation = false;
        foreach ($relations as $relation) {
            if ($this->$relation()->withTrashed()->count()) {
                $hasRelation = true;
                break;
            }
        }

        if ($hasRelation) {
            $this->delete();
        } else {
            $this->forceDelete();
        }
    }

    /**
     * Check whether the model has any relation and can deletable.
     *
     * @param array $relations
     */
    public function canSecureDelete(String ...$relations)
    {
        $hasRelation = false;
        foreach ($relations as $relation) {
            if ($this->$relation()->withTrashed()->count()) {
                $hasRelation = true;
                break;
            }
        }

        if ($hasRelation) {
            return false;
        } else {
            return true;
        }
    }
}
