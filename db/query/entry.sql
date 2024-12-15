-- name: CreateEntry :one
INSERT INTO entries (
    account_id,
    amount
) VALUES ($1, $2) RETURNING *;

-- name: GetEntryById :one
SELECT * FROM entries WHERE id = $1 LIMIT 1;

-- name: SearchEntries :many
SELECT * FROM entries ORDER BY id LIMIT $1 OFFSET $2;

-- name: UpdateEntry :exec
UPDATE entries SET amount = $2 WHERE id = $1;

-- name: DeleteEntry :exec
DELETE FROM entries where id = $1;