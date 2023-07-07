package hyung.jin.seo.jae.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import hyung.jin.seo.jae.dto.OutstandingDTO;
import hyung.jin.seo.jae.model.Outstanding;
import hyung.jin.seo.jae.repository.OutstandingRepository;
import hyung.jin.seo.jae.service.OutstandingService;

@Service
public class OutstandingServiceImpl implements OutstandingService {
	
	@Autowired
	private OutstandingRepository outstandingRepository;
   
	@Override
	public long checkCount() {
		long count = outstandingRepository.count();
		return count;
	}

	@Override
	public OutstandingDTO getOutstanding(Long id) {
		Outstanding stand = outstandingRepository.findById(id).orElseThrow(() -> new EntityNotFoundException("Outstanding not found"));
		OutstandingDTO dto = new OutstandingDTO(stand);
		return dto;
	}

	@Override
	public List<OutstandingDTO> getOutstandingtByInvoiceId(Long invoiceId) {
		List<OutstandingDTO> dtos = outstandingRepository.findByInvoiceId(invoiceId);
		return dtos;
	}

	@Override
	@Transactional
	public Outstanding addOutstanding(Outstanding stand) {
		return outstandingRepository.save(stand);
	}

	@Override
	public List<OutstandingDTO> allOutstandings() {
		List<Outstanding> stands = outstandingRepository.findAll();
		List<OutstandingDTO> dtos = new ArrayList<>();
		for(Outstanding stand: stands){
			OutstandingDTO dto = new OutstandingDTO(stand);
			dtos.add(dto);
		}
		return dtos;
	}

}
