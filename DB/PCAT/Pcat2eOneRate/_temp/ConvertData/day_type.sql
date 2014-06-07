select
	t1.DAY_TYPE_ID as dayTypeId,
	t2.RESELLER_VERSION_ID as resellerVersionId,
	t2.IS_DEFAULT as isDefault,
	t2.IS_INTERNAL as isInternal,
	t3.LANGUAGE_CODE as languageCode,
	t3.DISPLAY_VALUE as displayValue,
	t3.DESCRIPTION as description
from
	DAY_TYPE_ID_KEY t1
	inner join DAY_TYPE_ID_REF t2 on t1.DAY_TYPE_ID = t2.DAY_TYPE_ID
	inner join DAY_TYPE_ID_VALUES t3 on t2.DAY_TYPE_ID = t3.DAY_TYPE_ID
		and t2.RESELLER_VERSION_ID = t3.RESELLER_VERSION_ID
where
	t2.RESELLER_VERSION_ID = 2
	and t3.LANGUAGE_CODE = 1;
