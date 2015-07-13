for (i = 1; i < 47; i++)
{
    powers[i] =  2 * powers[i - 1];
    sum = sum + c[i] * powers[i];
}
