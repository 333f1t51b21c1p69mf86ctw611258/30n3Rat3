select
    t21.EXPRESSION_ID as expressionId,
    t22.RESELLER_VERSION_ID as resellerVersionId,
    t22.EXPRESSION_GROUP_ID as expressionGroupId,
    t22.ATTRIBUTE_ID as attributeId,
    t22.ATTRIBUTE_QUALIFIER as attributeQualifier,
    t22.VALUE as value,
    t22.ATTR_SRC as attrSrc
from
    EXPRESSION_KEY t21
    inner join EXPRESSION t22 on t21.EXPRESSION_ID = t22.EXPRESSION_ID
    inner join EXPRESSION_GROUP_KEY t23 on t22.EXPRESSION_GROUP_ID = t23.EXPRESSION_GROUP_ID
where
    t22.RESELLER_VERSION_ID = 2