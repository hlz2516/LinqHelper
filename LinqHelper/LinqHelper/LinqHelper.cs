using System;
using System.Collections.Generic;
using System.Linq;

namespace LinqHelper
{
    public static class LinqHelper
    {
        /// <summary>
        /// foreach语法糖，可带入index参数。
        /// 例：foreach((item,i) in items.WithIndex())...
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="source"></param>
        /// <returns></returns>
        public static IEnumerable<(T item, int index)> WithIndex<T>(this IEnumerable<T> source)
        {
            return source.Select((item, index) => (item, index));
        }
        /// <summary>
        /// 左连接，用法与join方法一致。
        /// </summary>
        /// <typeparam name="TLeft"></typeparam>
        /// <typeparam name="TRight"></typeparam>
        /// <typeparam name="TKey"></typeparam>
        /// <typeparam name="TResult"></typeparam>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <param name="leftKeySelector"></param>
        /// <param name="rightKeySelector"></param>
        /// <param name="resultSelector"></param>
        /// <returns></returns>
        public static IEnumerable<TResult> LeftJoin<TLeft, TRight, TKey, TResult>(
        this IEnumerable<TLeft> left,
        IEnumerable<TRight> right,
        Func<TLeft, TKey> leftKeySelector,
        Func<TRight, TKey> rightKeySelector,
        Func<TLeft, TRight, TResult> resultSelector)
        {
            var rightLookup = right.ToLookup(rightKeySelector);
            return left.SelectMany(
                leftItem => rightLookup[leftKeySelector(leftItem)].DefaultIfEmpty(),
                (leftItem, rightItem) => resultSelector(leftItem, rightItem)
            );
        }
    }
}
