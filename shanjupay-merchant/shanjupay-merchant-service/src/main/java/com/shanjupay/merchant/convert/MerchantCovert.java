package com.shanjupay.merchant.convert;

import com.shanjupay.merchant.api.dto.MerchantDTO;
import com.shanjupay.merchant.entity.Merchant;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;


/**
 * @author Lidadaibiao
 * @date 2020/6/3 - 22:15
 */
@Mapper
public interface MerchantCovert {
    MerchantCovert INSTANCE = Mappers.getMapper(MerchantCovert.class);

    MerchantDTO etity2dto(Merchant merchant);

    Merchant dto2etity(MerchantDTO merchantDTO);

}
