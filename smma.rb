require 'Daru'

def calculate_smma(df,period,column_name,apply_to)
    df_tmp = df[apply_to]
    first_val = df_tmp[0..(period-1)].mean()
    
    df_smma = Daru::DataFrame.new(val:df_tmp,smma:nil)
    df_smma[:smma][period] = first_val

    for index in (period+1)..(df_smma.size-1)
        df_smma[:smma][index] = (df_smma[:smma][index-1]*(period-1) + df_smma[:val][index]).to_f / period
        
    end
    df_smma
end


df = Daru::DataFrame.from_csv("EURUSD60.csv")
df_smma = calculate_smma(df,5,"smma","Close")