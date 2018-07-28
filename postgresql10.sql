CREATE TEMP TABLE users(id bigserial, group_id bigint);
INSERT INTO users(group_id) VALUES (1), (1), (1), (2), (1), (3);

SELECT min(id) min_id, group_id, count(id)
FROM (
	SELECT *,
		row_number() OVER (PARTITION BY group_id ORDER BY id) rn1,
		row_number() OVER (ORDER BY ID) rn2
	FROM users
	) q
GROUP BY group_id, rn2 - rn1
ORDER BY min_id;
