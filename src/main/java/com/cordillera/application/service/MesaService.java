package com.cordillera.application.service;

import com.cordillera.application.mapper.MesaMapper;
import com.cordillera.application.repository.jpa.MesaRepository;
import com.cordillera.domain.dto.MesaDto;
import com.cordillera.domain.models.Mesa;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MesaService {

    private final MesaMapper mesaMapper;
    @Autowired
    private MesaRepository mesaRepository;

    public MesaDto saveMesa(MesaDto mesaDto) throws Exception {
        Mesa mesaval = mesaRepository.findByNumeroMesa(mesaDto.getNumeroMesa()).orElse(null);

        if(mesaval!=null){
            throw new Exception("La mesa ya existe en el sistema");
        }
        return mesaMapper.mesaModeloToMesaDTO(mesaRepository.save(mesaMapper.mesaDTOToMesaModel(mesaDto)));
    }

    public void borrarMesa(@PathVariable BigDecimal numeromesa) throws Exception {
        Mesa mesaval = mesaRepository.findByNumeroMesa(numeromesa).orElse(null);
        if(mesaval==null){
            throw new Exception("Debe seleccionar al menos una mesa");
        }
        mesaRepository.deleteAllById(Collections.singleton(mesaval.getIdMesa()));
    }

    public MesaDto actulizarMesa(MesaDto mesaDto) throws Exception {
        Mesa mesaValId = mesaRepository.findById(mesaDto.getIdMesa()).orElse(null);
        if(mesaValId==null){
            throw new Exception("La mesa no existe en el sistema");
        }
        Mesa mesaValMesa = mesaRepository.findByNumeroMesa(mesaDto.getNumeroMesa()).orElse(null);
        if(mesaValMesa!=null){
            throw new Exception("La mesa YA existe en el sistema");
        }
        return mesaMapper.mesaModeloToMesaDTO(mesaRepository.save(mesaMapper.mesaDTOToMesaModel(mesaDto)));
    }
}
